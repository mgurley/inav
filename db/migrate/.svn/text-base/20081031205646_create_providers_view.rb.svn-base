class CreateProvidersView < ActiveRecord::Migration
  def self.up                                                                                                                       
      execute "CREATE VIEW providers_view as SELECT providers.id, providers.first_name, providers.last_name, providers.national_provider_identifier,  provider_types.name AS provider_types_name FROM providers LEFT JOIN provider_types ON providers.provider_type_id = provider_types.id WHERE providers.deleted_at is null"
  end

  def self.down
      execute "DROP VIEW providers_view"
  end
end
