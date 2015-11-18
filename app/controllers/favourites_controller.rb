class FavouritesController < ApplicationController

  before_action :authenticate_user

  def create
    favourite = Favourite.new
    question = Question.friendly.find(params[:question_id])
    favourite.question = question
    favourite.user = current_user
    if favourite.save
      FavouritesMailer.notify_question_owner(favourite).deliver_later
      redirect_to question_path(question), notice: "Thanks for favouriting!"
    else
      redirect_to question_path(question), notice: "You already favourited this!"
    end
  end

  def destroy
    question = Question.friendly.find params[:question_id]
    favourite = current_user.favourites.find_by_id params[:id]
    favourite.destroy
    redirect_to question_path(question), notice: "No more favourite."
  end


end
