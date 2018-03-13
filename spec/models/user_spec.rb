require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  it { should have_many(:goals) }
  it { should have_many(:comments) }

  describe "Password Encryption" do
    it "Encrypts the password using BCrypt" do
      user_params = {username: 'tommy', password: 'password'}
      expect(BCrypt::Password).to receive(:create).with(user_params[:password])
      User.new(user_params)
    end

    it "Does not save password to database" do
      User.create!(username: 'tommy', password: 'password')
      user = User.find_by(username: 'tommy')
      expect(user.password).not_to eq('password')
    end
  end

  describe "User#find_by_credentials" do
    it "Finds user by username and password" do
      user = User.create!(username: 'Tommy', password: 'password')
      expect(User.find_by_credentials('Tommy', 'password')).to eq(user)
    end
  end

  describe "Create session token" do
    it "Creates a new session token if not already present" do
      user = User.create!(username: 'Tommy', password: 'password')
      expect(user.session_token).not_to be_nil
    end
  end

end



# fidn_by(username, password)
#   user = find_by(username: username)
#   if user && user.is_password?(password)
#     user
#
