class AnswersController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :get_question!
  before_action :get_answer!, except: :create

  def update
    if @answer.update answer_params
      flash[:success] = "Answer updated successfully!"
      redirect_to question_path(@question, anchor: dom_id(@answer))
    else
      render :edit
    end
  end
  def edit
  end
  def create
    @answer = @question.answers.build answer_params
    if @answer.save
      flash[:success] = "Answer created successfully!"
      redirect_to question_path(@question)
    else
      @pagy, @answers = pagy Answer.where(question_id: @question.id).order created_at: :desc # или так @question.answers.order created_at: :desc
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer deleted successfully!"
    redirect_to question_path(@question)
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def get_question!
    @question = Question.find params[:question_id]
  end
  def get_answer!
    @answer = @question.answers.find params[:id]
  end
end
