require 'spec_helper'

describe DiscussionsController do
  describe "#create" do
    let(:discussion) {Discussion.new(:subject => "I'm a subject!", :body => "hi")}
    subject {post :create, {:discussion => discussion.as_json, :format => format } }

    describe "with json" do
      let(:format) {"json"}
      it "should not create a discussion" do
        expect {
          subject
        }.to change {Discussion.count}.by(0)
        response.should_not be_success
      end
    end

    describe "logged in" do
      before do
        session[:user_id] = users(:default).id
      end
      describe "with json" do
        let(:format) {"json"}
        it "should create a discussion" do
          expect {
            subject
          }.to change {Discussion.count}.by(1)
          response.should be_success
        end
      end
    end
  end
  describe "#update" do
    let(:discussion) {discussions(:default)}
    let(:discussion_update) { {:subject => "Another subject", :body => "Another body"} }
    subject {put :update, {:id => discussion.to_param, :discussion => discussion_update, :format => :json} }

    context "as no one" do
      it "Doesn't allow updates" do
        old_discussion = discussion.clone
        subject
        response.should_not be_success
        discussion.reload.should == old_discussion
      end
    end
    context "as another person" do
      before do
        session[:user_id] = User.create!(:username => "another person", :password => "weak sauce").id
      end
      it "Doesn't allow updates" do
        old_discussion = discussion.clone
        subject
        response.should_not be_success
        discussion.reload.should == old_discussion
      end
    end
    context "as the owner" do
      before do
        session[:user_id] = discussion.user.id
      end
      it "Allows update" do
        old_discussion = discussion.clone
        subject
        response.should be_success
        discussion.reload
        discussion.subject.should == "Another subject"
        discussion.body.should == "Another body"
      end
    end

  end
end