class ChangeOutcomeTypesData < ActiveRecord::Migration
  def self.up
    outcome_type = OutcomeType.find_by_name("Completed")
    outcome_type.name = "Closed"
    outcome_type.save!
    
    outcome_type = OutcomeType.create(:name =>"Quit", :created_by => 'system', :created_ip => '0.0.0.0')
    
    outcome_type.save!


  end

  def self.down
    outcome_type = OutcomeType.find_by_name("Closed")
    outcome_type.name = "Completed"
    outcome_type.save!
    
    outcome_type = OutcomeType.find_by_name("Quit")
    outcome_type.destroy!
    
  end
end
