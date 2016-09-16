class ProfilesController < ApplicationController
  # load_and_authorize_resource :except => :homepage
  before_action :authenticate_user! , :except => [:mannagers, :ourprojects ,  :homepage , :memari , :saze , :tasisat,:taghdirname,:darbareyema ,:tamasbama ,:mohitezist]
  before_action :set_profile, only: [:show, :edit, :update, :destroy , :addUser , :editUser]
  before_action :check_admin , only: [:addUser], only: [:destroy]
 
  # GET /profiles
  # GET /profiles.json
  def index
    #@profiles = User.all
     @user = current_user
   # byebug
    if @user.role == "پزشک" 
      @profiles = User.where("father_id = ?", @user.id)
     # byebug
    elsif @user.role == "ادمین" 
      @doctors = User.where("role = ? ", 'پزشک' )
      @profiles = []
      @doctors.each do |doctor|
        @profiles.push(doctor)
        @patients = User.where("father_id = ?", doctor.id)
        @patients.each do |patient|
          @profiles.push(patient)
        end
      end
    end
    #byebug
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = current_user
    @projects = Project.all 
    @user = current_user
  end

  def newUser
    #byebug
    @user = User.new
  end

  # GET /profile/editUser
  def editUser
    #byebug
    @user = current_user
  end

  #post /profile/updateUser
  def updateUser
    @user = current_user
    respond_to do |format|
      if @user.valid_password?(user_update_params[:current_password])
        params[:user].delete :current_password

       # byebug
        if @user.update(user_update_params)
          format.html { redirect_to url_for(:action=>'show', :controller=>'profiles' , :id => current_user.id), notice: 'Profile was successfully updated.' }
          format.json { render :show, status: :ok, location: url_for(:action=>'show', :controller=>'profiles' , :id => current_user.profile.id) }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html {redirect_to url_for(:action=>'editUser' , :controller=>'profiles') , notice: 'Your current password is wrong'}
      end
    end
  end

  def addUser
    
    @user = User.new(user_params)
    @user.father_id = current_user.id
    #byebug
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'user was successfully created.' }
      else
        format.html { render :newUser }
      end
    end

  end
  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update  
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to root_path
    end
 

    # @profile = User.find[]
    # @profile.destroy
    # respond_to do |format|
    #   format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def deleting
    byebug
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        #redirect_to root_path
    end
    
  end

  def mannagers
  end

  def ourprojects
  end


  def memari
  end

  def saze
  end

  def tasisat
  end

  def tamasbama
    redirect_to "contacts/new"
  end

  def darbareyema
  end

  def taghdirname
  end

  def projehabarayesherkat
  end

  def mohitezist
  end

  def mohitezist
  end

  def listmonshi
     @user = current_user
    if @user.role == "پزشک" 
      @profiles = User.where("father_id = ?", @user.id).where("role = ?", "منشی")
    end
    
  end

  private
    def check_admin
      unless current_user.role ==  "ادمین" || current_user.role == "پزشک" 
        #byebug
        redirect_to root_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = current_user.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:company_name, :work_experience, :register_number, :tel, :fax, :image , :avatar , :user_id)
    end
    def user_params
      params.require(:user).permit(:email, :password_confirmation, :password, :role ,:company_name , :work_experience ,:avatar, :register_number , :tel ,:fax, :father_id, :name ,:inclinic)
    end

    def user_update_params
      params.require(:user).permit(:email, :password_confirmation, :password, :role ,:company_name , :work_experience ,:avatar, :register_number , :tel ,:fax,:current_password, :father_id, :name ,:inclinic)
    end
end
