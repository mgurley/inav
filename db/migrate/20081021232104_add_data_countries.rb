class AddDataCountries < ActiveRecord::Migration
  def self.up
    down
    country = Country.create(:code =>"US",
                   :name => "United States",
                   :created_by => 'system',
                    :created_ip => '0.0.0.0')
    
    country.save!
 
  end

  def self.down
    execute "DELETE FROM countries;"
  end
end
