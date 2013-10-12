class QuestionsController < ApplicationController
  layout "dashboard"

  before_filter :authenticate_user!
  before_filter :current_question, except: [:index, :create, :new]

  def index
    @questions = company_questions.order(:created_at)
    @questions_data = @questions.map do |ques|
      ques.question_data_for_user(current_user)
    end
  end

  def show
  end

  def create
    @question = Question.new(question_params.merge({
      company: current_user.company,
      user: current_user
    }))
    if @question.save
      flash[:success] = 'New Question Added!'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def update
    if current_question.update_attributes(question_params)
      flash[:success] = 'Question Updated'
      redirect_to question_path(@campaign)
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'This question and all its answers are removed.'
    redirect_to questions_path
  end

  private

    def current_question
      @question = company_questions.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:content)
    end
end
