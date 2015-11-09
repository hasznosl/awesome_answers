class User < ActiveRecord::Base

  has_secure_password

  # this wont delete the dependent data from the database, only make the reference null
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

end