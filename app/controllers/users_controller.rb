class UsersController < ApplicationController

	# 
	# Method to create an user
	# 
	# @return [Hash] 
	def create
		@user = User.new(user_params)
	    if @user.save
	      api_response({user_id: @user.id}, 'User Created', :ok)
	    else
	      api_response(@user.errors, 'User cannot be created', :bad_request)
	    end
	end
	
	# 
	# Method to create an user
	# 
	# @return [Hash] 
	def show
		@user = User.find(params[:id]) rescue nil
		if @user
			api_response(@user, 'User Details', :ok)
		else
			api_response(nil, 'User id not present in the database', :bad_request)
		end
	end

	private 

  def user_params
    params.permit(:name, :contact_number)
  end
end