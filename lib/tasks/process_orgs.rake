namespace :db do
    desc "Update Org and People data from Berkeley API"
    task :process_orgs => :environment do
        OrgUnit.processOrgs
    end
end