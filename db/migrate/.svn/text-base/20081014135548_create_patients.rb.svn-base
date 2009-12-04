class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string  :first_name, :null => false 
      t.string  :last_name, :null => false 
      t.string  :middle_name
      t.date    :date_of_birth, :null => false 
      t.integer :gender_type_id, :null => false 
    
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

    execute "ALTER TABLE patients ADD CONSTRAINT gender_type_id_fkey FOREIGN KEY (gender_type_id) REFERENCES gender_types (id) DEFERRABLE;"
  end

  def self.down
   execute "ALTER TABLE patients DROP CONSTRAINT gender_type_id_fkey;"
   drop_table :patients
  end
end
