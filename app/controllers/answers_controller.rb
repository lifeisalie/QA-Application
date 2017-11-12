class AnswersController < ApplicationController

	def create
		@question = Question.find(params[:question_id])
		if(current_user)
			@answer = @question.answers.create(answer_params.merge(user_id: current_user.id, name: current_user.name))
			@answer.name = current_user.name
			puts @answer.name
		else
			puts session[:omniauth]['uid']
			@answer = @question.answers.create(answer_params.merge(user_id: 1, name: session[:omniauth]['info']['name'] ))
			puts @answer.name
		end
		puts answer_params
		redirect_to question_path(@question)
	end

	def destroy
		@question = Question.find(params[:question_id])
		@answer = @question.answers.find(params[:id])
		@answer.destroy
		redirect_to question_path(@question)
	end

	def show
		if @answer.reviews.blank?
			@average_review = 0
		else
			@average_review = @answer.reviews.average(:rating).round(2)
		end
	end
	
	private def answer_params
		params.require(:answer).permit(:body)
	end

end
