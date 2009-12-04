class CreatePatientsView < ActiveRecord::Migration
  def self.up
      execute "CREATE VIEW patients_view as SELECT patients.id, patients.first_name, patients.last_name, patients.date_of_birth, gender_types.name AS gender_types_name FROM patients LEFT JOIN gender_types ON patients.gender_type_id = gender_types.id WHERE patients.deleted_at is null"
  end

  def self.down
      execute "DROP VIEW patients_view"
  end
end
