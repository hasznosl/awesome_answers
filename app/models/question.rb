class Question < ActiveRecord::Base

  # dependent: :destroy will destroy all answers referenceing a question just before deleting the question
  # dependent: :nullify - obvious
  has_many :answers, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :votes

  belongs_to :user

  validates(:title, {presence: true,
                      uniqueness: {message: "Was already used"},
                      length: {minimum: 3}})
  validates :body, presence: true,
                    uniqueness: {scope: :title}
                      #using scope: :title will make sure thath the body is unique
                      # in combination with the title

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  validate :no_monkey

  # we can have any combination of [before || after]_[initialize || validation || save || commit]
  after_initialize :set_default_values
  before_validation :capitalize_title

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]


  # the scope does the same as the below commented out
  # scope takes in two arguments -> method name, and lambda
  # scope is rails
  scope :recent_ten, lambda { order("created_at DESC").limit(10) }
  # def self.recent_ten
  #   order("created_at DESC").limit(10)
  # end

  def self.recent(num)
    order("created_at DESC").limit(num)
  end

  def self.search(string)
    where("title ILIKE ? OR body ILIKE ?", "%#{string}%", "%#{string}%")
  end

  def liked_by? user
    like_for(user).present? if user
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end


  def favourited_by? user
    favourite_for(user).present? if user
  end

  def favourite_for(user)
    favourites.find_by_user_id(user.id)
  end

  def voted_on_by?(user)
    vote_for(user).present?
  end

  def vote_for(user)
    votes.find_by_user_id(user.id)
  end

  def vote_result
    votes.select{|v| v.is_up?}.count - votes.select{|v| !v.is_up?}.count
  end

  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  private
    # this is a custom validation method
    def no_monkey
      if title.present? && title.downcase.include?("monkey")
        errors.add(:title, "No monkeys please!")
      end
    end

    def set_default_values
      self.view_count ||= 7
    end


    def capitalize_title
      self.title.capitalize! if title
    end

end
