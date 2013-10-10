class AnswersController < ApplicationController
  layout "dashboard"

  before_filter :authenticate_user!
  before_filter :current_answer, except: [:create]

  # def index
  #   @answers = company_answers
  # end

  def create
    question = company_questions.find(params[:question_id])
    @answer = Answer.new(answer_params.merge({
      question: question,
      user: current_user
    }))
    if @answer.save
      flash[:success] = 'New Question Added!'
      redirect_to question_path(question)
    else
      render :edit
    end
  end

  def update
    if answer_params[:content].length == 0
      return destroy
    end
    if @answer.update_attributes(answer_params)
      flash[:success] = 'Answer Updated'
      redirect_to question_path(@answer.question)
    else
      render 'edit'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Answer Removed'
    redirect_to question_path(@answer.question)
  end

  private

    def current_answer
      @answer = company_answers.where(id: params[:id]).first
    end

    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
end
