class CreateContactMechanismTypes < ActiveRecord::Migration
  def self.up
    create_table :contact_mechanism_types do |t|
      t.string :name, :null => false 

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
  end

  def self.down
    drop_table :contact_mechanism_types
  end
end
