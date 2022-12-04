class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_recipe 
    
    def index
        recipes=Recipe.all
        render json: recipes, status: :created
    end

    def create
        recipe=Recipe.create!(recipe_params)
        render json: recipe, serializer:RecipesSerializer, status: :created  
    end

    private
    def invalid_recipe invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
     end
     
     def recipe_params
        params.permit(:title,:instructions,:minutes_to_complete)
    end

    def authorize
        return render json: {errors: ["Unauthorized access"]}, status: :unauthorized unless session.include? :user_id
    end
end
