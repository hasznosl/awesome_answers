# The convention in Rails is to use pluralized model name if The
# controller is related to that model. Use the pluralize method to see how Rails
# understands pluralized form.

class QuestionsController < ApplicationController


  # before action will register a method that will be executed
  # before all actions unless you specify options such as
  # except or only
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    @q = Question.new
  end

  def create
    # create will save to the database
    # Question.create title: params[:question][:title],
    #                 body: params[:question][:body]})

    @q = Question.new(question_params)
    if @q.save
      # redirect_to question_path( id: @q.id)
      redirect_to question_path(@q), notice: "Question created successfully."
    else
      # render text: "Didn't save correctly. #{@q.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def destroy
    @q.destroy
    flash[:notice] = "Question deleted successfully"
    redirect_to questions_path
  end

  def edit
  end

  def update

    if @q.update(question_params)
      redirect_to question_path(@q), notice: "Question updated successfully."
    else
      render :edit
    end
  end


  def index
    @questions = Question.all
  end

  def show
  end

  private

    def find_question
      @q = Question.find params[:id]
    end

    def question_params
      # this is called Mass assignment
      # without the whitelist, hackers could chaneg other other attributes of the model
      # happened to github, people hacked others ssh keys
      question_params = params.require(:question).permit([:title, :body])
    end

end
