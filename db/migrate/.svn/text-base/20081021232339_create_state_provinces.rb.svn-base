class CreateStateProvinces < ActiveRecord::Migration
  def self.up
    create_table :state_provinces do |t|
      t.string :name, :null => false, :limit => 100
      t.string :code, :null => false, :limit => 10
      t.integer :country_id,  :null => false

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
    execute "ALTER TABLE state_provinces ADD CONSTRAINT country_id_fkey FOREIGN KEY (country_id) REFERENCES countries (id) DEFERRABLE;"
  end

  def self.down
    execute "ALTER TABLE state_provinces DROP CONSTRAINT country_id_fkey;"
    drop_table :state_provinces
  end
end
