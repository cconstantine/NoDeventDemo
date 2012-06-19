#=require models/tweet

describe "Tweet", ->
  it "#new", ->
    expect(new Tweet({})).toNotBe(null)