require 'spec_helper'

describe NotificationController, :type => :controller do
  describe 'Notification Controller' do
    before :each do
      @user = User.create!(:name => 'test1', :email => 'test@test.com', :password => 'password')
      sign_in :user, @user
    end

    # index Action
    describe "index" do
      # user notification page
      it "renders the following template" do
        get :index

        expect(response).to render_template("index")
      end
    end

    describe "create" do
      it "renders the following template and check the decline of notification" do
        post :create, email: "test@test.com", type: "Decline"
        expect(response).to redirect_to notification_index_path
      end

      it "should not creates a new notification on wrong email" do
        post :create, email: "test334@test.com", type: "request"
        expect(response).to redirect_to connection_index_path
      end

      it "should creates a new notification on right email" do
        User.create!(:name => 'test1', :email => 'test1@test.com', :password => 'password')

        post :create, email: "test1@test.com", type: "request"
        expect(response).to redirect_to connection_index_path
      end
    end
  end
end
