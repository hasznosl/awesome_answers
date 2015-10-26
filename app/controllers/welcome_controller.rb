class WelcomeController < ApplicationController

  def index

  end


  def greeting
    #this will capture the variable in the dynamic url
    @name = params[:name]
  end

  def hello
    # this line is implied by convention
    # if we comment it out it doesn't matter, rails does it by default
    # render :hello, layout: "application"
    #
    # hello.html.erb ---> [action].[response format].[templating language]
    # action comes from the controller
    # response format default is html
    # default templating language is erb
  end

end
