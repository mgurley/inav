class CreatePatientProviderAssignments < ActiveRecord::Migration
  def self.up
    create_table :patient_provider_assignments do |t|
      t.integer :patient_id,                      :null => false 
      t.integer :provider_id,                       :null => false 
      t.string :description

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
    execute "ALTER TABLE patient_provider_assignments ADD CONSTRAINT patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients (id) DEFERRABLE;"
    execute "ALTER TABLE patient_provider_assignments ADD CONSTRAINT provider_id_fkey FOREIGN KEY (provider_id) REFERENCES providers (id) DEFERRABLE;"
  end

  def self.down
    execute "ALTER TABLE patient_provider_assignments DROP CONSTRAINT patient_id_fkey;"    
    execute "ALTER TABLE patient_provider_assignments DROP CONSTRAINT provider_id_fkey;"        

    drop_table :patient_provider_assignments
  end
end
