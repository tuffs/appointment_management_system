class User < ApplicationRecord
  # Include bcrypt methods for password encryption
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validate :password_requirements

  private

    def password_requirements
      # Password Requirements:
        # - must take several characters
        # - must take at least one number
        # - must take at least one special character

      return if password.blank? # Skip if password is nil or empty (handled by presence validation)

      unless password.match?(/\A(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,}\z/)
        errors.add(:password, 'must be at least 8 characters long, include at least one number, and one special character.')
      end
    end
end
