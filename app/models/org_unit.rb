class OrgUnit < ActiveRecord::Base
	attr_accessible :org_node, :org_node_description, :level
end