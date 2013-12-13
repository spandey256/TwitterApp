require 'spec_helper'

describe ConnectionController, :type => :controller do
  describe 'Connection Controller' do
    before :each do
      @user = User.create!(:name => 'test1', :email => 'test@test.com', :password => 'password')
      sign_in :user, @user
    end

    # index Action
    describe "index" do
      # user connections page
      it "renders the following template" do
        get :index
        fw=Connection.find_all_by_follower_id @user.id
        fw.should eq(assigns(:following_list))

        fw=Connection.find_all_by_following_id @user.id
        fw.should eq(assigns(:follower_list))
        expect(response).to render_template("index")
      end

      # user connections page
      it "renders the following template" do
        get :index
        expect(response).to render_template("index")
      end




    end


    describe "update" do

      it "redirects to the following path" do
        put :update, id: 2
        expect(response).to redirect_to connection_index_path
      end



      it "redirects to the following path and delete a connection" do
        user2 = User.create!(:name => 'test2', :email => 'test2@test.com', :password => 'password')
        Connection.create!(following: user2, follower: @user)
        put :update, id: 1
        Connection.all.count.should eq(0)
        expect(response).to redirect_to connection_index_path
      end


      describe "create" do

        it "redirects to the following path and creates a connection" do
          Notification.create! to: @user, from: User.create!(:name => 'test1', :email => 'test2@test.com', :password => 'password'), note_type: "request"
          post :create, email: "test2@test.com"
          Connection.all.count.should eq(1)
          expect(response).to redirect_to notification_index_path
        end

        it "what if email id is wrong" do
          Notification.create! to: @user, from: User.create!(:name => 'test1', :email => 'tes@test.com', :password => 'password'), note_type: "request"
          post :create, email: "tes@test.com"
          Connection.all.count(0)
          expect(response).to redirect_to notification_index_path
        end

      end



    end
  end
end