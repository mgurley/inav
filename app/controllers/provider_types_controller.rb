class ProviderTypesController < ApplicationController
  # GET /provider_types
  # GET /provider_types.xml
  def index
    @provider_types = ProviderType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @provider_types }
    end
  end

  # GET /provider_types/1
  # GET /provider_types/1.xml
  def show
    @provider_type = ProviderType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provider_type }
    end
  end

  # GET /provider_types/new
  # GET /provider_types/new.xml
  def new
    @provider_type = ProviderType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider_type }
    end
  end

  # GET /provider_types/1/edit
  def edit
    @provider_type = ProviderType.find(params[:id])
  end

  # POST /provider_types
  # POST /provider_types.xml
  def create
    @provider_type = ProviderType.new(params[:provider_type])

    respond_to do |format|
      if @provider_type.save
        flash[:notice] = 'ProviderType was successfully created.'
        format.html { redirect_to(@provider_type) }
        format.xml  { render :xml => @provider_type, :status => :created, :location => @provider_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /provider_types/1
  # PUT /provider_types/1.xml
  def update
    @provider_type = ProviderType.find(params[:id])

    respond_to do |format|
      if @provider_type.update_attributes(params[:provider_type])
        flash[:notice] = 'ProviderType was successfully updated.'
        format.html { redirect_to(@provider_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provider_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /provider_types/1
  # DELETE /provider_types/1.xml
  def destroy
    @provider_type = ProviderType.find(params[:id])
    @provider_type.destroy

    respond_to do |format|
      format.html { redirect_to(provider_types_url) }
      format.xml  { head :ok }
    end
  end
end
