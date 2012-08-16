require 'spec_helper'

describe SessionsController do
  describe "#create" do
    let(:user) {users(:default)}
    subject {post :create, {:username => username, :password => password, :format => format }}

    describe "with valid credentials" do
      let(:username) {user.username}
      let(:password) {'asdfasdf'}

      describe "as json" do
        let(:format) {"json"}
        it "logs me in" do
          subject
          response.should be_success
          response.body.should == user.to_json
          session[:user_id].should == user.id
        end
      end
    end


    describe "with invalid credentials" do
      let(:username) {user.username}
      let(:password) {'asdf'}

      describe "as json" do
        let(:format) {"json"}
        it "should not log me in" do
          subject
          response.should_not be_success
          session[:user_id].should be_nil
        end
      end
    end
  end
end