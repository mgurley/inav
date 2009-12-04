class AddMoreDataContactMechanismTypes < ActiveRecord::Migration
  def self.up

    contact_mechanism_type = ContactMechanismType.find_by_name("Home Phone" )
    unless contact_mechanism_type
      contact_mechanism_type = ContactMechanismType.new(:name => 'Home Phone', :created_by => 'system', :created_ip => '0.0.0.0')
      contact_mechanism_type.save!
    end
    
    contact_mechanism_type = ContactMechanismType.find_by_name("Work Phone" )
    unless contact_mechanism_type
      contact_mechanism_type = ContactMechanismType.new(:name => 'Work Phone', :created_by => 'system', :created_ip => '0.0.0.0')
      contact_mechanism_type.save!
    end

    contact_mechanism_type = ContactMechanismType.find_by_name("Fax" )
    unless contact_mechanism_type    
      contact_mechanism_type = ContactMechanismType.new(:name => 'Fax', :created_by => 'system', :created_ip => '0.0.0.0')
      contact_mechanism_type.save!
    end

    contact_mechanism_type = ContactMechanismType.find_by_name("Other" )
    unless contact_mechanism_type
      contact_mechanism_type = ContactMechanismType.new(:name => 'Other', :created_by => 'system', :created_ip => '0.0.0.0')
      contact_mechanism_type.save!
    end

  end

  def self.down
  end
end
