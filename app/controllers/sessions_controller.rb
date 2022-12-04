class SessionsController < ApplicationController
 before_action :unauthorized, only: [:destroy]
    def create
        user=User.find_by(username:params[:username])
        if user&.authenticate(params[:password])
            session[:user_id]=user.id
            render json: user
        else
            render json: {errors: ["Invalid username or password"]}, status: :unauthorized
        end
    end

    def destroy
        session.delete :user_id
        return head :no_content
    end

    private
    def unauthorized
       return render json: {errors:["Unauthorized access"]}, status: :unauthorized unless session.include? :user_id
    end

end
