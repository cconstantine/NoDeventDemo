FixtureBuilder.configure do |fbuilder|

  fbuilder.files_to_check += Dir["spec/support/fixture_builder.rb"]

  fbuilder.factory do
    fbuilder.name(:default, User.create(:username => "cconstantine", :password => 'asdfasdf'))
  end
end