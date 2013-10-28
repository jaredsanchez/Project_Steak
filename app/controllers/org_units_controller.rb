require 'nokogiri'              # XML parser

class OrgUnitsController < ApplicationController
  include OrgUnitsControllerHelper
  def index
    @units = OrgUnit.find(:all)
  end

  def create
    # get all orgs from API and write each one to database
    #1.upto(7) do |i|
      debugger
      xml_doc = getOrgs(1)
        xml_doc.xpath('//OrganizationUnit').each do |unit|
          org_unit = Hash.new
          org_unit['org_node'] = unit['orgNode']
          org_unit['org_node_description'] = unit['orgNodeDescription']
          org_unit['level'] = unit['level']
          OrgUnit.create!(org_unit)
        end
    #end
    redirect_to org_units_path
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
