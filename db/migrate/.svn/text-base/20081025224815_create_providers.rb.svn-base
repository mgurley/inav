class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :first_name,                         :null => true
      t.string :last_name,                          :null => true
      t.string :middle_name
      t.integer :provider_type_id,                  :null => true
      t.string :national_provider_identifier

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
    execute "ALTER TABLE providers ADD CONSTRAINT provider_type_id_fkey FOREIGN KEY (provider_type_id) REFERENCES provider_types (id) DEFERRABLE;"

  end

  def self.down
    execute "ALTER TABLE providers DROP CONSTRAINT provider_type_id_fkey;"
    drop_table :providers
  end
end