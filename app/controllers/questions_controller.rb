class QuestionsController < ApplicationController
	
	def new
  		@question = Question.new()
	end

	def index
		@questions = Question.all
	end

	def show
		@question = Question.find(params[:id])
	end

	def create
		#render plain: params[:post].inspect
		@question = Question.new(question_params)
		if(@question.save)
			uri = URI('http://127.0.0.1:5000/stuff')
			response = Net::HTTP.post_form(uri, 'question' => @question.qtext, 'text' => @question.description)
			# response = Net::HTTP.get_response(uri)
			@answer = @question.answers.create(response)
			redirect_to question_path(@question)
		else
			render "new"
		end
	end


	def edit
		@question = Question.find(params[:id])
	end

	def update
		@question = Question.find(params[:id])
		if(@question.update(question_params))
			redirect_to @question
		else
			render 'edit'
		end
	end

	def destroy
		@question = Question.find(params[:id])
		@question.destroy

		redirect_to questions_path
	end


	private def question_params
		params.require(:question).permit(:qtext, :description)
	end

end
