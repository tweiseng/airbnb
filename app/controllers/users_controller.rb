class UsersController < Clearance::UsersController



 def new
    @user = user_from_params
    render template: "users/new"
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


def user_from_params
  user_params = params[:user] || Hash.new
  email = user_params.delete(:email)
  password = user_params.delete(:password)
  first_name = user_params.delete(:first_name)
  last_name = user_params.delete(:last_name)



  Clearance.configuration.user_model.new(user_params).tap do |user|
    user.email = email
    user.password = password
    user.first_name = first_name
    user.last_name = last_name
    
    end
  end

  def permit_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :birthday)
    end
end



