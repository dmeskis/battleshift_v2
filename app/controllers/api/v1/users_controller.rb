module Api
  module V1
    class UsersController < ApiController
      def index
        render json: User.all
      end

      def show
        render json: User.find(params[:id])
      end

      def update
        user = User.update(params[:id], user_params)
      end

      private
        def user_params
          params.permit(:id, :name, :email)
        end
    end
  end
end
