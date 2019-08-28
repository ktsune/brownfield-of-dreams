require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'activate' do
    let(:user) { create(:user, uuid: '13579') }
    let(:mail) { described_class.activate(user).deliver_now }

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
        .to match("http://localhost:3000/activate?uuid=#{user.uuid}")
    end
  end

  describe 'invite' do
    let(:user) { create(:user) }
    let(:handle) { 'Mr. Handle' }
    let(:email) { 'handle@github.com' }
    let(:mail) { described_class.invite(user, handle, email).deliver_now }

    it 'renders subject' do
      expect(mail.subject).to eq("#{user.first_name} invited you to Turing Tutorials.")
    end

    it 'renders emails' do
      expect(mail.from).to eq(['noreply@turingtutorials.com'])
      expect(mail.to).to eq([email])
    end

    it 'renders body' do
      expect(mail.body.encoded).to match('Hello Mr. Handle!')
      expect(mail.body.encoded).to match("#{user.first_name} has invited you to join Turing Tutorials.")
      expect(mail.body.encoded).to match('/register')
    end
  end
end
