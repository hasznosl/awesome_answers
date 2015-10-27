class Question < ActiveRecord::Base

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
      self.title.capitalize!
    end

end
