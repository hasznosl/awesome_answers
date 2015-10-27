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

end
