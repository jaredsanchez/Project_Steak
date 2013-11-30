require 'debugger'
require 'nokogiri'

class Person < ActiveRecord::Base
    extend ApplicationHelper
	
    has_and_belongs_to_many :events
    attr_accessible :name, :first_name, :last_name, :progress, :active, :favorite, :email, :linkedin_connection => false

    def self.processPeople(org_unit)
        uri = "https://apis.berkeley.edu/calnet/person?searchFilter" +
          "=(departmentNumber=" + org_unit['org_node'] + ")&attributesToReturn=displayName,berkeleyEduFirstName,berkeleyEduLastName" +
          #"=(departmentNumber=" + "EH1EO" + ")&attributesToReturn=displayname" +  
          "&app_id=" + ENV['CAL_NET_ID'] + "&app_key=" + ENV['CAL_NET_KEY']
        doc = getXML(uri)
        doc.xpath('//person').map do |person|
          first_name = person.xpath('berkeleyedufirstname').inner_text.split(" ")
          if first_name != []
            first_name = first_name.first.capitalize
            last_name = person.xpath('berkeleyedulastname').inner_text.capitalize
          else
            name = person.xpath('displayname').inner_text.split(" ")
            first_name = name.first.capitalize
            last_name = name.last.capitalize
          end
          updated_person = Person.find_or_initialize_by_first_name_and_last_name(first_name, last_name)
          new_person = Hash.new
          new_person['first_name'] = first_name
            new_person['last_name'] = last_name
          new_person['progress'] = updated_person.progress || 0
          new_person['active'] = true
          updated_person.update_attributes(new_person)
        end
    end

    def self.deactivateAllPeople()
        self.update_all "active = 'false'"
    end
end
