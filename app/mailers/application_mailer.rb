# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@turingtutorials.com'
  layout 'mailer'
end
