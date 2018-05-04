class UsersController < Clearance::UsersController
 before_action :permit_params, only: [:update]
  def new     
    @user = user_from_params     
    render template: "users/new"       
  end      

  def index
    @user = User.all
  end

  def create
  @user = user_from_params
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
    # render 'edit'
  end

  def update
    @user = User.find(params[:id])
    # byebug
    if @user.update(permit_params)
     flash[:x] = "edited"
     else
      flash[:x] = "not edited"
     end 
    
    redirect_to:"listings"
  end



  def user_from_params
    user_params = params[:user] || Hash.new
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    image = user_params.delete(:image)
    role = user_params.delete(:role)
    


    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.image = image
      user.role = role
    end
  end

    def permit_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :birthday, :image, :role)
    end
end



