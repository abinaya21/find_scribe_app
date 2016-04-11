class UsersController < ApplicationController
  def new
  	@user = User.new
  	@user.is_volunteer = (params["is_volunteer"].nil?) ? false : params["is_volunteer"]
  	if(@user.is_volunteer)
  		@volunteer = @user.build_volunteer
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
end
