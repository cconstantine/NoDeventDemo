require 'spec_helper.rb'

describe User do
  describe "validations" do
    it "should require a password" do
      expect {
        User.create!(:username => 'foo')
      }.to raise_error ActiveRecord::RecordInvalid
    end
    it "should require a username" do
      expect {
        User.create!(:password => 'foo')
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end