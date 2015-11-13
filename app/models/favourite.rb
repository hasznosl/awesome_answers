class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :question_id, uniqueness: {scope: :user_id}

  def user_full_name
    user.full_name
  end

end
