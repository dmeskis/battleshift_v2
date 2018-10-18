require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before(:each) do
    @user = create(:user)
    @user.activation_token = User.new_token
  end
  
  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(@user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(["no-reply@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
