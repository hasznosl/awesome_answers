class FavouritesMailer < ApplicationMailer

  def notify_question_owner(favourite)
    @favourite = favourite
    @question = @favourite.question
    @owner    = @question.user
    if @owner.email.present?
      mail(to: @owner.email, subject: "Your question was favourited by #{favourite.user_full_name}!")
    end
  end

end
