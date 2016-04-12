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
  			redirect_to :users
  			return
  		end
	  elsif(@user.save)
		  redirect_to :users
		  return
	  end

	  render "new"
  end

  def update
    @user = User.update_attributes(params[:user])
    if(@user.is_volunteer)
      @volunteer = @user.volunteer.update_attributes(params[:volunteer])

      if(@user.valid? && @volunteer.valid?)
        @user.save
        @volunteer.save
        redirect_to :users
        return
      end
    elsif(@user.save)
      redirect_to :users
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
