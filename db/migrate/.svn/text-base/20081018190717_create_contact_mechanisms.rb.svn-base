class CreateContactMechanisms < ActiveRecord::Migration
  def self.up
    create_table :contact_mechanisms do |t|
      t.string :contact_mechanism_code, :null => false 
      t.integer :contact_mechanism_type_id, :null => false 
      t.string :contactable_type, :null => false 
      t.integer :contactable_id, :null => false 

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
    execute "ALTER TABLE contact_mechanisms ADD CONSTRAINT contact_mechanism_type_id_fkey FOREIGN KEY (contact_mechanism_type_id) REFERENCES contact_mechanism_types (id) DEFERRABLE;"
  end

  def self.down
    execute "ALTER TABLE contact_mechanisms DROP CONSTRAINT contact_mechanism_type_id_fkey;"
    drop_table :contact_mechanisms
  end
end




