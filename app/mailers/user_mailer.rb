# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: 'Activate your account.')
  end

  def invite(user, handle, email)
    @user = user; @handle = handle
    mail(to: email, subject: "#{user.first_name} invited you to Turing Tutorials.")
  end
end
