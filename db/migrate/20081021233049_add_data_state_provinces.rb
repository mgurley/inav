class AddDataStateProvinces < ActiveRecord::Migration
  def self.up
    down
    
    state_province = StateProvince.create(:code => "AL",
                   :name => "Alabama",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!



    state_province = StateProvince.create(:code => "AK",
                   :name => "Alaska",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "AS",
                   :name => "American Samoa",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!



    state_province = StateProvince.create(:code => "AZ",
                   :name => "Arizona",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!

    state_province = StateProvince.create(:code => "AR",
                   :name => "Arkansas",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "CA",
                   :name => "California",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "CO",
                   :name => "Colorado",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "CT",
                   :name => "Connecticut",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!

	 	
    state_province = StateProvince.create(:code => "DE",
                   :name => "Delaware",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "DC",
                   :name => "Dist. of Columbia",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "FL",
                   :name => "Florida",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "GA",
                   :name => "Georgia",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "GU",
                   :name => "Guam",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!

    state_province = StateProvince.create(:code => "HI",
                   :name => "Hawaii",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "ID",
                   :name => "Idaho",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "IL",
                   :name => "Illinios",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "IN",
                   :name => "Indiana",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
			 :country_id => Country.find_by_code("US"))
    
    state_province.save!


    state_province = StateProvince.create(:code => "IA",
                   :name => "Iowa",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!

    state_province = StateProvince.create(:code => "KS",
                   :name => "Kansas",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "KY",
                   :name => "Kentucky",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "LA",
                   :name => "Louisiana",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "ME",
                   :name => "Maine",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MD",
                   :name => "Maryland",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MH",
                   :name => "Marshall Islands",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MA",
                   :name => "Massachusetts",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MI",
                   :name => "Michigan",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!

    state_province = StateProvince.create(:code => "FM",
                   :name => "Micronesia",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MN",
                   :name => "Minnesota",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MS",
                   :name => "Mississippi",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MO",
                   :name => "Missouri",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "MT",
                   :name => "Montana",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NE",
                   :name => "Nebraska",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NV",
                   :name => "Nevada",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NH",
                   :name => "New Hampshire",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NJ",
                   :name => "New Jersey",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NM",
                   :name => "New Mexico",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NY",
                   :name => "New York",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "NC",
                   :name => "North Carolina",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "ND",
                   :name => "North Dakota",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!

    state_province = StateProvince.create(:code => "MP",
                   :name => "Northern Marianas",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "OH",
                   :name => "Ohio",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "OK",
                   :name => "Oklahoma",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!



    state_province = StateProvince.create(:code => "OR",
                   :name => "Oregon",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "PW",
                   :name => "Palau",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "PA",
                   :name => "Pennsylvania",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "PR",
                   :name => "Puerto Rico",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "RI",
                   :name => "Rhode Island",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "SC",
                   :name => "South Carolina",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!

    state_province = StateProvince.create(:code => "SD",
                   :name => "South Dakota",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "TN",
                   :name => "Tennessee",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!

    state_province = StateProvince.create(:code => "TX",
                   :name => "Texas",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "UT",
                   :name => "Utah",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "VT",
                   :name => "Vermont",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "VA",
                   :name => "Virginia",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "VI",
                   :name => "Virgin Islands",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "WA",
                   :name => "Washington",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "WV",
                   :name => "West Virginia",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!


    state_province = StateProvince.create(:code => "WI",
                   :name => "Wisconsin",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!



    state_province = StateProvince.create(:code => "WY",
                   :name => "Wyoming",
                   :created_by => 'system',
                   :created_ip => '0.0.0.0',
    	 :country_id => Country.find_by_code("US"))

    state_province.save!

 
  end

  def self.down
    execute "DELETE FROM state_provinces;"
 end
end





