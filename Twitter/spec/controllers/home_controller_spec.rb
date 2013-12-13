require 'spec_helper'

describe HomeController, :type => :controller do
  describe 'Home Controller' do
    before :each do
      @user = User.create!(:name => 'test1', :email => 'test@test.com', :password => 'password')
      sign_in :user, @user
    end

    # index Action
    describe "index" do

      # user login home page with no page parameter
      it "renders the following template" do
        get :index
        expect(response).to render_template("index")
      end

      # user login home page with page parameter
      it "renders the following template with page parameter" do
        get :index, page: 2
        expect(response).to render_template("index")
      end

      # user login home page with page parameter having large value
      it "renders the following template with page parameter having large value" do
        get :index, page: 210
        expect(response).to render_template("index")
      end

    # create action
    describe "create" do

      # posting new tweet
      it "creates new post" do
        post :create, :tweet => 'hello'
        UserTweet.where(user_id: @user.id,tweet: "hello").exists?.should eq(true)
        expect(response).to redirect_to home_index_path
      end

      # posting new blank tweet
      it "creates new post with blank tweet" do
        post :create, :tweet => ''
        UserTweet.where(user_id: @user.id,tweet: "").exists?.should eq(false)
        expect(response).to redirect_to home_index_path
      end

    end


    end
  end
end