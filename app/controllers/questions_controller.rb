# The convention in Rails is to use pluralized model name if The
# controller is related to that model. Use the pluralize method to see how Rails
# understands pluralized form.

class QuestionsController < ApplicationController

  def new

  end

  def create
    # create will save to the database
    # Question.create title: params[:question][:title],
    #                 body: params[:question][:body]})

    # this is called Mass assignment
    # without the whitelist, hackers could chaneg other other attributes of the model
    # happened to github, people hacked others ssh keys
    question_params = params.require(:question).permit([:title, :body])
    q = Question.new(question_params)
    if q.save
      render text: "Saved Correctly."
    else
      render text: "Didn't save correctly. #{q.errors.full_messages.join(", ")}"
    end
  end

  def destroy
  end

  def edit
  end

  def show
  end

end
