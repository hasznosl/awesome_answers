# The convention in Rails is to use pluralized model name if The
# controller is related to that model. Use the pluralize method to see how Rails
# understands pluralized form.

class QuestionsController < ApplicationController

  def new
    @q = Question.new
  end

  def create
    # create will save to the database
    # Question.create title: params[:question][:title],
    #                 body: params[:question][:body]})

    # this is called Mass assignment
    # without the whitelist, hackers could chaneg other other attributes of the model
    # happened to github, people hacked others ssh keys
    question_params = params.require(:question).permit([:title, :body])
    @q = Question.new(question_params)
    if @q.save
      # redirect_to question_path( id: @q.id)
      redirect_to question_path(@q)
    else
      # render text: "Didn't save correctly. #{@q.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def destroy
    @q = Question.find(params[:id])
    @q.destroy
    redirect_to questions_path
  end

  def edit
    @q = Question.find(params[:id])
  end

  def update
    @q = Question.find(params[:id])
    question_params = params.require(:question).permit([:title, :body])
    if @q.update(question_params)
      redirect_to question_path(@q)
    else
      render :edit
    end
  end


  def index
    @questions = Question.all
  end

  def show
    @q = Question.find(params[:id])
  end

end
