class AddDataAddressTypes < ActiveRecord::Migration
  def self.up
    down
    address_type = AddressType.create(:name =>"Home", :created_by => 'mjg994', :created_ip => '0.0.0.0')
    
    address_type.save!
 
    address_type = AddressType.create(:name =>"Office", :created_by => 'mjg994', :created_ip => '0.0.0.0')
    
    address_type.save!
 
 
  end

  def self.down
    execute "DELETE FROM address_types;"
  end
end



