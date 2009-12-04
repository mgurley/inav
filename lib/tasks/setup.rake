namespace :setup do
  desc 'Medical Record Number Types'
  task(:medical_record_types => :environment) do
    medical_record_number_types = YAML::load_file(RAILS_ROOT+'/lib/setup/data/medical_record_number_types.yml')

    medical_record_number_types[:medical_record_number_types].each do |medical_record_number_type|
      save_medical_record_number_type(medical_record_number_type[:name])
    end
  end
end

def save_medical_record_number_type(name)
  medical_record_number_type = MedicalRecordNumberType.find(:first, :conditions => ["name = ?", name])
  if medical_record_number_type
    puts "#{name}... already exists"
  else
    puts "Inserting #{name}..."
    MedicalRecordNumberType.create!(:name => name, :created_by => 'system', :created_ip => '0.0.0.0')
  end
end
