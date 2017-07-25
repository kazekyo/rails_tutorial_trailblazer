class User::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build( constant: User::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()
  step :send_activation_email

  def send_activation_email(options)
    user = options["model"]
    UserMailer.account_activation(user).deliver_now
  end
end
