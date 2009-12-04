class AddDataContactMechanismTypes < ActiveRecord::Migration
  def self.up
    down
    contact_mechanism_type = ContactMechanismType.new(:name => 'Phone', :created_by => 'system', :created_ip => '0.0.0.0')
    contact_mechanism_type.save!

    contact_mechanism_type = ContactMechanismType.new(:name => 'Mobile Phone', :created_by => 'system', :created_ip => '0.0.0.0')
    contact_mechanism_type.save!

    contact_mechanism_type = ContactMechanismType.new(:name => 'Email', :created_by => 'system', :created_ip => '0.0.0.0')
    contact_mechanism_type.save!

  end

  def self.down
    execute "DELETE FROM contact_mechanism_types;"
  end
end
