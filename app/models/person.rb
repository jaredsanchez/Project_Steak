class Person < ActiveRecord::Base
    extend ApplicationHelper
	
    has_and_belongs_to_many :events
    has_and_belongs_to_many :groups
    attr_accessible :name, :first_name, :last_name, :progress, :active, :favorite, :email,
     :linkedin_connection, :phone_number, :cal_net_dept_name, :hr_dept_name, :job_title, :room_number, :building

    def self.search(search)
      if search
        ids = []
        search.split(' ').each do |term|
	  people = find(:all, :conditions => ['first_name LIKE ? OR 
	    last_name LIKE ? OR 
            hr_dept_name LIKE ? OR 
	    cal_net_dept_name LIKE ? OR
	    email LIKE ? OR 
            building LIKE ?', 
            "%#{term}%", "%#{term}", "%#{term}%", "%#{term}", "%#{term}", "%#{term}"])
          people.each do |p|
            ids << p.id
          end
        end
        find(ids)
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

    def full_name
      "#{first_name} " + "#{last_name}"
    end
end
