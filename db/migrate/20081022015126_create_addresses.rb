class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string  :attention,                   :null => true
      t.string  :address_line_1,              :null => false
      t.string  :address_line_2
      t.string  :state_province_name,         :null => false
      t.string  :city,                        :null => false
      t.string  :postal_code,                 :null => false, :limit => 50
      t.integer :country_id,                  :null => false
      t.integer :addressable_id,              :null => false
      t.string  :addressable_type,            :null => false
      t.integer :address_type_id,             :null => false

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

    execute "ALTER TABLE addresses ADD CONSTRAINT country_id_fkey FOREIGN KEY (country_id) REFERENCES countries (id) DEFERRABLE;"
    execute "ALTER TABLE addresses ADD CONSTRAINT address_type_id_fkey FOREIGN KEY (address_type_id) REFERENCES address_types (id) DEFERRABLE;"
  end

  def self.down
    execute "ALTER TABLE addresses DROP CONSTRAINT country_id_fkey;"
    execute "ALTER TABLE addresses DROP CONSTRAINT address_type_id_fkey;"
    drop_table :addresses
  end
end