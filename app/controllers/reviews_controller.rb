class ReviewsController < ApplicationController
	before_action :find_answer
	before_action :find_review, only: [:edit, :update]
	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.answer_id = @answer.id
		if current_user
			@review.user_id = current_user.id
		elsif session[:omniauth]
			@review.user_id = 1
		end
		if @review.save
			@question = @answer.question
			redirect_to question_path(@question)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		@review = Review.find(params[:id])

		if @review.update(review_params)
			@question = @answer.question
			redirect_to question_path(@question)
		else
			render 'edit'
		end
	end

	private
		def review_params
			params.require(:review).permit(:rating)
		end

		def find_answer
			@answer = Answer.find(params[:answer_id])
		end

		def find_review
			@review = Review.find(params[:id])
		end
end
