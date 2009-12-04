class AddDataGenderTypes < ActiveRecord::Migration
  def self.up
    down
    gender_type = GenderType.new(:name => 'Male', :created_by => 'system', :created_ip => '0.0.0.0')
    gender_type.save!

    gender_type = GenderType.new(:name => 'Female', :created_by => 'system', :created_ip => '0.0.0.0')
    gender_type.save!

    gender_type = GenderType.new(:name => 'Unknown', :created_by => 'system', :created_ip => '0.0.0.0')
    gender_type.save!

    gender_type = GenderType.new(:name => 'Not Specified', :created_by => 'system', :created_ip => '0.0.0.0')
    gender_type.save!

  end

  def self.down
    execute "DELETE FROM gender_types;"
  end
end
