class AnswersController < ApplicationController

  before_action :authenticate_user

  def create
    answer_params = params.require(:answer).permit(:body)
    # params[:question_id] is coming from the url
    @q = Question.friendly.find(params[:question_id])
    @answer = current_user.answers.new(answer_params)
    # this associates the answer with question @q
    @answer.question = @q
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        format.html{redirect_to question_path(@q), notice: "Answer created successfully!"}

        #this will render views/answers/create_success.js.erb
        format.js {render :create_success}
      else
        # render -> same request cycle, I still have every class variables
        # redirect -> not
        format.html{render "questions/show"}
        format.js {render :create_failure}
      end
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    redirect_to root_path, alert: "Access Denied!" unless can? :destroy, @answer
    @answer.destroy
    respond_to do |format|
      format.html{redirect_to question_path(@answer.question), notice: "Answer deleted"}
      format.js{render} #destroy.js.erb
    end
  end

end
