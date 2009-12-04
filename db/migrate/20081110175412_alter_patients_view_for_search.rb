class AlterPatientsViewForSearch < ActiveRecord::Migration
  def self.up
      execute "DROP VIEW patients_view"
      execute "CREATE VIEW patients_view as SELECT patients.id, patients.first_name, patients.last_name, patients.date_of_birth, gender_types.name AS gender_types_name, patient_medical_record_numbers.medical_record_number AS medical_record_number FROM patients LEFT JOIN gender_types ON patients.gender_type_id = gender_types.id LEFT JOIN patient_medical_record_numbers on patients.id = patient_medical_record_numbers.patient_id WHERE patients.deleted_at is null"
  end

  def self.down
      execute "DROP VIEW patients_view"
      execute "CREATE VIEW patients_view as SELECT patients.id, patients.first_name, patients.last_name, patients.date_of_birth, gender_types.name AS gender_types_name FROM patients LEFT JOIN gender_types ON patients.gender_type_id = gender_types.id WHERE patients.deleted_at is null"
  end
end
