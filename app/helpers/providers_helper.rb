module ProvidersHelper
  def get_provider_types
    ProviderType.find(:all, :order=>'name').collect { | a | [a.name, a.id ] }
  end

  def get_providers
    Provider.find(:all, :order=>'first_name').collect { | a | [a.first_name + ' ' + a.last_name, a.id ] }
  end
end
