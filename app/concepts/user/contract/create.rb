require "reform/form/validation/unique_validator"

module User::Contract
  class Create < Reform::Form
    property :name, validates: { presence: true, length: { maximum: 50 } }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    property :email, validates: {
        presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        unique: { case_sensitive: false }
    }
    property :password, validates: { presence: true, length: { minimum: 6 }, allow_nil: true, confirmation: true }
    property :password_confirmation, validates: { presence: true, length: { minimum: 6 }, allow_nil: true }
  end
end
