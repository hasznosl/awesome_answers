class AnswersController < ApplicationController

  before_action :authenticate_user
  before_action :authorize, only: [:edit, :update, :destroy]

  def create
    answer_params = params.require(:answer).permit(:body)
    # params[:question_id] is coming from the url
    @q = Question.friendly.find(params[:question_id])
    @answer = current_user.answers.new(answer_params)
    # this associates the answer with question @q
    @answer.question = @q
    if @answer.save
      AnswersMailer.notify_question_owner(@answer).deliver_later
      redirect_to question_path(@q), notice: "Answer created successfully!"
    else
      # render -> same request cycle, I still have every class variables
      # redirect -> not
      render "questions/show"
    end
  end

  def destroy
    answer = Answer.find params[:id]
    redirect_to root_path, alert: "Access Denied!" unless can? :delete, @q
    answer.destroy
    redirect_to question_path(answer.question), notice: "Answer deleted"
  end

  def authorize
    redirect_to root_path, alert: "Access Denied!" unless can? :manage, @q
  end

end
