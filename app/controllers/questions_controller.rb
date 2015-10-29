# The convention in Rails is to use pluralized model name if The
# controller is related to that model. Use the pluralize method to see how Rails
# understands pluralized form.

class QuestionsController < ApplicationController

  def new

  end

  def create
    # create will save to the database
    Question.create title: params[:question][:title],
                    body: params[:question][:body]})
    render text: "Inside Questions Create: #{params[:question]}"
  end

  def destroy
  end

  def edit
  end

  def show
  end

end
