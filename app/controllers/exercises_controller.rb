class ExercisesController < ApplicationController
    # 新規作成ページを表示
    def new
        @exercise = Exercise.new
    end
    
    # Exerciseを新規作成
    def create
        Exercise.create(exercise_parameter)
        redirect_to events_url
    end
    
    private
    
    # Exerciseのパラメータ
    # @return [ActiveRecord::Relation] パラメータ
    def exercise_parameter
        params.require(:exercise).permit(:name, :label)
    end
end
