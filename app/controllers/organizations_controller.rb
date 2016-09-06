class OrganizationsController < ApplicationController
  before_action :require_current_user
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :create_new_organization, only: [:new, :create]

  include SessionsHelper

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.where(owner_identifier: current_user_identifier)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    
  end

  # GET /organizations/new
  def new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization.assign_attributes(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_organization
      @organization = Organization.find_by(id: params[:id], owner_identifier: current_user_identifier)
      redirect_to(organizations_url, alert: 'You do not own this organization.') if @organization.nil?
    end

    def create_new_organization
      @organization = Organization.new(owner_identifier: current_user_identifier)
    end

    def organization_params
      params.require(:organization).permit(:name)
    end
end
