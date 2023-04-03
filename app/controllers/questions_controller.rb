class QuestionsController < ApplicationController

  # чтобы  постоянно в методах (show destroy edit update)
  # не писать @question = Question.find_by id: params[:id]
  # создаем before_action а он уже это делает  в самом начале
  # в методах которые мы указали (show destroy edit update)
  before_action :get_question!, only: %i[show destroy edit update]
  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate
  end

  def new
    @question = Question.new
  end
  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Question created successfully!"
      redirect_to questions_path
    else
      render :new
    end
  end
  def edit
    # работает before_action с Question.find_by id: params[:id]
  end
  def update
    # работает before_action с Question.find_by id: params[:id]
    if @question.update question_params
      flash[:success] = "Question updated successfully!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def show
    # работает before_action с Question.find_by id: params[:id]
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy Answer.where(question_id: @question.id).order(created_at: :desc) # или так @question.answers.order created_at: :desc
    @answers = @answers.decorate
  end
  def destroy
    # работает before_action с Question.find_by id: params[:id]
    @question.destroy
    flash[:success] = "Question deleted successfully!"
    redirect_to questions_path
  end
  def question_params
    params.require(:question).permit(:title, :body)
  end

  private

  def get_question!
    @question = Question.find params[:id]
  end
end