class CreateOutcomeTypes < ActiveRecord::Migration
  def self.up
    create_table :outcome_types do |t|
      t.string :name,                           :null => false 

      t.string    :created_by,   :null => false
      t.string    :updated_by
      t.string    :deleted_by
      t.string    :created_ip,  :null => false
      t.string    :deleted_ip
      t.string    :updated_ip      
      t.timestamp :created_at, :null => false
      t.timestamp :updated_at, :null => false
      t.datetime  :deleted_at
    end
    
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
    drop_table :outcome_types
  end
end