require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'instructions' do

    let(:user) { mock_model User, name: 'Aurie', email: 'aurie@email.com' }
    let(:mail) { described_class.instructions(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Activate your account.')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply@turingtutorials.com'])
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://localhost:3000/activate?user_id=#{user.id}")
    end
  end
end
