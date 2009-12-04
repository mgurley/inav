module AddressesHelper
  def get_address_types
    AddressType.find(:all, :order=>'name').collect { | c | [c.name, c.id ] }
  end

  def get_countries
    Country.find(:all, :order=>'name').collect { | c | [c.name, c.id ] }
  end

  def get_state_provinces
    StateProvince.find(:all, :order=>'name').collect { | c | [c.name, c.name ] }
  end
end