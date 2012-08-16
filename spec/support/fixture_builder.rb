FixtureBuilder.configure do |fbuilder|

  fbuilder.files_to_check += Dir["spec/support/fixture_builder.rb"]

  fbuilder.factory do
    default_user = User.create!(:username => "cconstantine", :password => 'asdfasdf')
    fbuilder.name(:default, default_user)

    default_discussion = Discussion.new(:user => default_user, :subject => "A Subject", :body => "A body")
    default_discussion.user = default_user
    default_discussion.save!
    fbuilder.name(:default, default_discussion)
  end
end