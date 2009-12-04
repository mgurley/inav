class AddDataOutcomeTypes < ActiveRecord::Migration
  def self.up
    down
    outcome_type = OutcomeType.create(:name =>"Open", :created_by => 'system', :created_ip => '0.0.0.0')
    
    outcome_type.save!

    outcome_type = OutcomeType.create(:name =>"Death", :created_by => 'system', :created_ip => '0.0.0.0')
    
    outcome_type.save!


    outcome_type = OutcomeType.create(:name =>"Moved to other Institution", :created_by => 'system', :created_ip => '0.0.0.0')
    
    outcome_type.save!


    outcome_type = OutcomeType.create(:name =>"Completed", :created_by => 'system', :created_ip => '0.0.0.0')
    
    outcome_type.save!


    outcome_type = OutcomeType.create(:name =>"Other", :created_by => 'system', :created_ip => '0.0.0.0')
    
    outcome_type.save!


  end

  def self.down
    execute "DELETE FROM outcome_types;"
  end
end
