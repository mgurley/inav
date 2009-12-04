class ProviderView < ActiveRecord::Base
  set_table_name "providers_view"

  named_scope :by_first_name_last_name_npi, lambda { |search|
    {:conditions => ["LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR national_provider_identifier LIKE ? OR LOWER(first_name)||' '||LOWER(last_name) LIKE ?", "%#{search.to_s.downcase}%","%#{search.to_s.downcase}%","%#{search}%","%#{search.to_s.downcase}%"]}
  }

  cattr_reader :per_page
  @@per_page = 10


  def self.search(page, sort, search)

    sort = case sort
           when "first_name"  then "first_name"
           when "first_name_reverse"  then "first_name DESC"
           when "last_name"  then "last_name"
           when "last_name_reverse"  then "last_name DESC"
           when "provider_types_name"  then "provider_types_name"
           when "provider_types_name_reverse"  then "provider_types_name DESC"
           when "national_provider_identifier"  then "national_provider_identifier"
           when "national_provider_identifier_reverse"  then "national_provider_identifier DESC"
           else "first_name"
           end

     if search
       ProviderView.by_first_name_last_name_npi(search).paginate :page => page, :order => sort
     else
       ProviderView.paginate :page => page, :order => sort
     end
  end
end
