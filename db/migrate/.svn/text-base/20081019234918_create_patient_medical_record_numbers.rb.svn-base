class CreatePatientMedicalRecordNumbers < ActiveRecord::Migration
  def self.up
    create_table :patient_medical_record_numbers do |t|
      t.integer :patient_id, :null => false 
      t.string :medical_record_number, :null => false 
      t.integer :medical_record_number_type_id, :null => false 

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
    execute "ALTER TABLE patient_medical_record_numbers ADD CONSTRAINT patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients (id) DEFERRABLE;"
    execute "ALTER TABLE patient_medical_record_numbers ADD CONSTRAINT medical_record_number_type_id_fkey FOREIGN KEY (medical_record_number_type_id) REFERENCES medical_record_number_types (id) DEFERRABLE;"
    
  end

  def self.down
    execute "ALTER TABLE patient_medical_record_numbers DROP CONSTRAINT patient_id_fkey;"
    execute "ALTER TABLE patient_medical_record_numbers DROP CONSTRAINT medical_record_number_type_id_fkey;"
    drop_table :patient_medical_record_numbers
  end
end





