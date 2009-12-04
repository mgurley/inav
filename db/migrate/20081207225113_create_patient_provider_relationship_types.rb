class CreatePatientProviderRelationshipTypes < ActiveRecord::Migration
  def self.up
    create_table :patient_provider_relationship_types do |t|
      t.string :name,                               :null => false    
      t.boolean :is_allowed_free_text,              :null => false
      t.string  :created_by,                        :null => false
      t.string  :updated_by
      t.string    :created_ip,                      :null => false
      t.string    :updated_ip            
      t.timestamp  :created_at,                     :null => false 
      t.timestamp  :updated_at,                     :null => false
      t.datetime :deleted_at      
    end
  end

  def self.down
    drop_table :patient_provider_relationship_types
  end
end
