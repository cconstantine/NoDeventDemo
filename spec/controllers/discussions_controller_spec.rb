require 'spec_helper'

describe DiscussionsController do
  describe "#create" do
    let(:discussion) {Discussion.new(:body => "hi")}
    subject {post :create, {:discussion => discussion.as_json, :format => format } }

    describe "with json" do
      let(:format) {"json"}
      it "should not be allowed" do
        expect {
          subject
        }.to_not change {Discussion.count}
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
end