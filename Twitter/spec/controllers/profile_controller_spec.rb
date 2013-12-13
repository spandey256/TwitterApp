require 'spec_helper'

describe ProfileController, :type => :controller do
  describe 'Profile Controller' do
    before :each do
      @user = User.create!(:name => 'test1', :email => 'test@test.com', :password => 'password')
      sign_in :user, @user
    end

    # index Action
    describe "index" do

      # user profile page
      it "renders the following template" do
        get :index, user_id: 1
        expect(response).to render_template("index")
      end

      # user profile page with unknown user_id
      it "renders the following template with unknown user_id" do
        get :index, user_id: 100
        expect(response).to render_template("index")
      end

      # user profile page when no user is signed in
      it "renders the following template even when no user is logged in" do
        sign_out @user
        get :index, user_id: 100
        expect(response).to render_template("index")
      end

    end
  end
end