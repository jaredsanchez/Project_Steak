class OrgUnit < ActiveRecord::Base
    extend ApplicationHelper

    attr_accessible :org_node, :org_node_description, :level


    def self.processOrgs
    # get all orgs from API and write each one to database
    #1.upto(7) do |i|
      Person.deactivateAllPeople()
      xml_doc = getOrgs(1)

      xml_doc.xpath('//OrganizationalUnit').map do |unit|
        orgName = unit.xpath('orgNode').inner_text
        unless orgName == "--"
          node = OrgUnit.find_or_initialize_by_org_node(orgName)
          org_unit = Hash.new
          org_unit['org_node'] = orgName
          org_unit['org_node_description'] = unit.xpath('orgNodeDescription').inner_text
          org_unit['level'] = unit.xpath('level').inner_text
          node.update_attributes(org_unit)
          Person.processPeople(org_unit)
        end
      end
    #end
    end
    
    def self.getOrgs(level)
        #uri = "https://apis-dev.berkeley.edu/cxf/asws/orgunit?level=" + level.to_s +
        uri = "https://apis-dev.berkeley.edu/cxf/asws/orgunit?orgNode=EH1EO" + 
          "&_type=xml&app_id=" + ENV['ORG_APP_ID'] + "&app_key=" + ENV['ORG_APP_KEY']
        doc = getXML(uri)
    end

end