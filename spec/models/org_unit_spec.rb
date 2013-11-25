require 'spec_helper'

describe OrgUnit do
    it 'should add org units to the database' do
        OrgUnit.processOrgs
        units = OrgUnit.all
        units.should_not eq([])
    end

end