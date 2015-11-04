class AnswersController < ApplicationController

  def create
    answer_params = params.require(:answer).permit(:body)
    # params[:question_id] is coming from the url
    @q = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    # this associates the answer with question @q
    @answer.question = @q
    if @answer.save
      redirect_to question_path(@q), notice: "Answer created successfully!"
    else
      # render -> same request cycle, I still have every class variables
      # redirect -> not
      render "questions/show"
    end
  end

  def destroy
    answer = Answer.find params[:id]
    answer.destroy
    redirect_to question_path(answer.question), notice: "Answer deleted"
  end

end
