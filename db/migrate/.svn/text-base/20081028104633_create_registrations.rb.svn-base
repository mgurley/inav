class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.integer :patient_id,                      :null => false 
      t.string :site_assigned_identifier,         :null => false 
      t.string :study_assigned_identifier,        :null => false 
      t.string :study_segment_id,                 :null => false 
      t.string :epoch_study_segment_name,         :null => false 
      t.string :outcome
      t.integer :referring_provider_id,           :null => false 

      t.string  :created_by,                       :null => false
      t.string  :updated_by
      t.string    :created_ip,                      :null => false
      t.string    :updated_ip            
      t.timestamp  :created_at,                     :null => false 
      t.timestamp  :updated_at,                     :null => false
      t.datetime :deleted_at      
    end
    execute "ALTER TABLE registrations ADD CONSTRAINT patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients (id) DEFERRABLE;"
    execute "ALTER TABLE registrations ADD CONSTRAINT referring_provider_id_fkey FOREIGN KEY (referring_provider_id) REFERENCES providers (id) DEFERRABLE;"    
  end

  def self.down
    execute "ALTER TABLE registrations DROP CONSTRAINT patient_id_fkey;"    
    execute "ALTER TABLE registrations DROP CONSTRAINT referring_provider_id_fkey;"        
    drop_table :registrations
  end
end

