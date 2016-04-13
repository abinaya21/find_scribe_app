class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]

  def new
  	@user = User.new
  	@user.is_volunteer = (params["is_volunteer"].nil?) ? false : params["is_volunteer"]
  	if(@user.is_volunteer)
  		@volunteer = @user.build_volunteer
  	end
  end

  def edit
    @user = User.find(params[:id])
    if(@user.is_volunteer)
      @volunteer = @user.volunteer
    end
  end

  def create

  	@user = User.new(params[:user])
  	if(@user.is_volunteer)
  		@volunteer = @user.build_volunteer(params[:volunteer])

		  if(@user.valid? && @volunteer.valid?)
  			@user.save
  			@volunteer.save
        sign_in @user
        flash[:success] = "Registration Successful!"
  			redirect_to service_requests_path
  			return
  		end
	  elsif(@user.save)
		  sign_in @user
      flash[:success] = "Registration Successful!"
      redirect_to service_requests_path
		  return
	  end

	  render "new"
  end

  def update
    @user.assign_attributes(params[:user])
    if(@user.is_volunteer)
      @volunteer = @user.volunteer
      @volunteer.assign_attributes(params[:volunteer])

      if(@user.valid? && @volunteer.valid?)
        @user.save
        @volunteer.save
        sign_in @user
        flash[:success] = "Profile updated successfully!"
        redirect_to edit_user_path(current_user)
        return
      end
    elsif(@user.save)
      sign_in @user
      flash[:success] = "Profile updated successfully!"
      redirect_to edit_user_path(current_user)
      return
    end

    render "edit"
  end

  private

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
end
