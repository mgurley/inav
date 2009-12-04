class AlterRegistrationsForOutcomes < ActiveRecord::Migration
  def self.up
    add_column(:registrations, :outcome_type_id, :integer, :null => true )

    change_column_null(:registrations, :outcome_type_id, false, OutcomeType.find_by_name("Open"))

    execute "ALTER TABLE registrations ADD CONSTRAINT outcome_type_id_fkey FOREIGN KEY (outcome_type_id) REFERENCES outcome_types (id) DEFERRABLE;"

    change_column(:registrations, :outcome, :text)

  end

  def self.down
    execute "ALTER TABLE registrations DROP CONSTRAINT outcome_type_id_fkey;"    
    remove_column(:registrations, :outcome_type_id)
  end
end
