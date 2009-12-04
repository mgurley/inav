class ProvidersController < ApplicationController
  helper :addresses
  before_filter :find_provider, :only => [:show, :edit, :update, :destroy, :auto_complete_show]
  before_filter :provider_referrer_url, :only =>[:show, :new, :edit]

  # GET /providers
  # GET /providers.xml
  def index
    respond_to do |format|
      format.html {@providers = ProviderView.search(params[:page], params['sort'], params['search'])}
      format.xml  {@providers = ProviderView.find(:all); render :xml => @providers }
      format.js   { render :partial  => "providers/providers_search", :layout => false}
    end
  end

  # GET /providers/1
  # GET /providers/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.xml
  def new
    @provider = Provider.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  # POST /providers.xml
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        flash[:notice] = 'Provider was successfully created.'
        format.html { redirect_to(@provider) }
        format.xml  { render :xml => @provider, :status => :created, :location => @provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.xml
  def update
    params[:provider][:contact_mechanism_attributes] ||= {}
    params[:provider][:address_attributes] ||= {}
    @provider.attributes = params[:provider]

    respond_to do |format|
      if @provider.save
        flash[:notice] = 'Provider was successfully updated.'
        format.html { redirect_to(@provider) }
        #format.html { redirect_to(@patient) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.xml
  def destroy
    flash[:error] = 'Deleting providers is not supported.'
    respond_to do |format|
      format.html { redirect_to(providers_url) }
      format.xml  { render :xml => @provider.errors.add_to_base(flash[:error]), :status => :unprocessable_entity }
    end
  end

  def auto_complete
    @providers = Provider.by_auto_complete(params[:search])
    render :inline => '<%= model_auto_completer_result(@providers, :full_name_with_npi, params[:search].to_s) %>'
  end

  def auto_complete_show
    respond_to do |format|
      format.js {render :partial => "/patient_provider_assignments/patient_provider_assignment_provider", :layout => false, :locals => {:provider => @provider}  }
    end
  end

  private

  def find_provider
    @provider = Provider.find(params[:id])
  end

  def provider_referrer_url
    session[:provider_referrer_url] = request.env["HTTP_REFERER"] unless request.env["HTTP_REFERER"] == "#{request.protocol}#{request.host_with_port}#{request.request_uri}"
  end
end
