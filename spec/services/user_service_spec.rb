require 'rails_helper'

describe UserService do
  before :each do
    @params = {id: 1,
               name: "Bob",
               email: "mail@mail.com"}
  end
  it "exists" do
    service = UserService.new()

    expect(service).to be_a(UserService)
  end

  context "instance methods" do
    context "#find_user" do
      it "returns a single user" do
        file = File.open("./fixtures/single_user.json")
        stub_request(:get, "http://localhost:3000/api/v1/users/1").
          to_return(body: file, status: 200)

        service = UserService.new(@params)

        expect(service.find_user).to be_a(Hash)
        expect(service.find_user).to have_key(:name)
        expect(service.find_user).to have_key(:email)
      end
    end
  end
  context "#all_users" do
    it "returns all users" do
      file = File.open("./fixtures/multiple_users.json")
      stub_request(:get, "http://localhost:3000/api/v1/users").
        to_return(body: file, status: 200)

      service = UserService.new(@params)

      expect(service.all_users).to be_a(Array)
      expect(service.all_users.first).to have_key(:name)
      expect(service.all_users.first).to have_key(:email)
    end
  end
end
