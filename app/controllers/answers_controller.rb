class AnswersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :current_answer, except: [:index, :create, :new]

  def index
    @answers = company_answers
  end

  def show
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = Answer.new(answer_params.merge({
      question: question
    }))
    if @answer.save
      flash[:success] = 'New Question Added!'
      redirect_to question_answer_path(@answer)
    else
      render :edit
    end
  end

  def update
    if @answer.update_attributes(answer_params)
      flash[:success] = 'Answer Updated'
      redirect_to question_answer_path(@answer)
    else
      render 'edit'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Answer Removed'
    redirect_to questions_path(@answer.question)
  end

  private

    def current_answer
      @answer = company_answers.where(id: params[:id])
    end

    def answer_params
      params.require(:answer).permit(:content, :question)
    end
end
