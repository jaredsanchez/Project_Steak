class Person < ActiveRecord::Base
    extend ApplicationHelper
	
    has_and_belongs_to_many :events
    attr_accessible :name, :first_name, :last_name, :progress, :active, :favorite, :email,
     :linkedin_connection, :phone_number, :cal_net_dept_name, :hr_dept_name, :job_title, :room_number, :building

    def self.search(search)
      if search
	find(:all, :conditions => ['first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%"])
      else
        find.all
      end
    end

    def self.processPeople(org_unit)
        uri = "https://apis.berkeley.edu/calnet/person?searchFilter" +
          "=(departmentNumber=" + org_unit['org_node'] + ")&attributesToReturn=displayName," +
          "berkeleyEduFirstName,berkeleyEduLastName,berkeleyEduUnitCalNetDeptName,berkeleyEduUnitHRDeptName,mail," +
          "title,telephoneNumber,street,roomNumber" +
          "&app_id=" + ENV['CAL_NET_ID'] + "&app_key=" + ENV['CAL_NET_KEY']
        doc = getXML(uri)
        #debugger
        doc.xpath('//person').map do |person|

          first_name, last_name = get_names_from_XML(person)

          email = get_from_XML(person, 'mail')
          phone_number = get_from_XML(person, 'telephonenumber')
          job_title = get_from_XML(person, 'title')
          room_number, building = get_address_from_XML(person)

          updated_person = Person.find_or_initialize_by_first_name_and_last_name(first_name, last_name)
          new_person = Hash.new
          new_person['first_name'] = first_name
          new_person['last_name'] = last_name
          new_person['progress'] = updated_person.progress || 0
          new_person['active'] = true
          new_person['cal_net_dept_name'] = person.xpath('berkeleyeduunitcalnetdeptname').inner_text
          new_person['hr_dept_name'] = person.xpath('berkeleyeduunithrdeptname').inner_text
          new_person['email'] = updated_person.email || email
          new_person['phone_number'] = updated_person.phone_number || phone_number
          new_person['job_title'] = job_title
          new_person['room_number'] = room_number
          new_person['building'] = building
          updated_person.update_attributes(new_person)
        end
    end

    def self.deactivateAllPeople()
        self.update_all "active = 'false'"
    end

    def self.get_from_XML(person, field)
      attribute = person.xpath(field).inner_text
        if attribute == ""
          attribute = nil
        end
        return attribute
    end

    def self.get_names_from_XML(person)
      #displayname is the only name parameter guaranteed to exist.
      first_name = person.xpath('berkeleyedufirstname').inner_text.split(" ")
      if first_name != []
        first_name = first_name.first.capitalize
        last_name = person.xpath('berkeleyedulastname').inner_text.capitalize
      else
        name = person.xpath('displayname').inner_text.split(" ")
        first_name = name.first.capitalize
        last_name = name.last.capitalize
      end
      return first_name, last_name
    end

    #Parses the room number and building from two possible API fields.
    #It's possible that only a number is contained in the roomnumber field,
    #but more often roomnumber contains a number and a building.
    #It's also possible that roomnumber is empty in which case street has both
    #the number and the building. 369 Soda Hall will return as 369 and Soda.
    #The Hall is stripped off.
    def self.get_address_from_XML(person)
      room_number = nil
      building = nil
      room_number_string = person.xpath('roomnumber').inner_text
      unless room_number_string == ""
        room_number_string =~ /(\d*)\s*([a-zA-Z]*)\s*([a-zA-Z]*)/
        room_number = $1
        unless $2 == ""
          building = $2
        end
      end
      street_string = person.xpath('street').inner_text
      street_string =~ /(\d*)\s*([a-zA-Z]*)\s*([a-zA-Z]*)/
      unless room_number
        room_number = $1
      end
      unless building
        building = $2
      end
      building = building.gsub(/\bhall\b/i, "").strip
      return room_number, building
    end
end
