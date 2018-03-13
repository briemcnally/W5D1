require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET#new" do
    it "renders the new user template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST#create" do
    context "with valid params" do
      before :each do
        post :create, params: { user: { username: 'tommy', password: 'password' } }
        @user = User.find_by(username: 'tommy')
      end

      it "signs the user in" do
        expect(session[:session_token]).to eq(@user.session_token)
      end

      it "redirects the user to goals page" do
        expect(response).to redirect_to(goals_url)
      end
    end

    context "with invalid params" do
      it "renders the new template with errors" do
        post :create, params: { user: { username: 'tommy', password: '' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
end
