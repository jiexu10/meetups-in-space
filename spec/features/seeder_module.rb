module Seeder
  def seed_db
    user1 = User.create({provider: "abc", uid: "testuid", username: "testusername", email: "testemail@test.com", avatar_url: "testav_url"})
    user2 = User.create({provider: "def", uid: "testuid2", username: "testusername2", email: "testemail2@test.com", avatar_url: "testav_url2"})
    User.create({provider: "ghi", uid: "testuid3", username: "testusername3", email: "testemail3@test.com", avatar_url: "testav_url3"})
    User.create({provider: "jkl", uid: "thecreator", username: "thisguycreates", email: "creatoremail@test.com", avatar_url: "creator_url"})

    Meetup.create({name: "coolthing", description: "fun", location: "somewhere", creator_id: 1})
    Meetup.create({name: "otherthing", description: "alsofun", location: "somewhereelse", creator_id: 1})
    Meetup.create({name: "test3", description: "descript3", location: "boston3", creator_id: 3})
    Meetup.create({name: "test4", description: "descript4", location: "boston4", creator_id: 2})
    Meetup.create({name: "test5", description: "descript5", location: "boston5", creator_id: 3})

    Comment.create({body: "asdf1", user_id: 1, meetup_id: 1})
    Comment.create({body: "asdf2", user_id: 1, meetup_id: 2})
    Comment.create({body: "asdf2", user_id: 3, meetup_id: 2})
    Comment.create({body: "asdf3", user_id: 2, meetup_id: 1})
    Comment.create({body: "asdf4", user_id: 1, meetup_id: 3})
    Comment.create({body: "asdf4", user_id: 2, meetup_id: 3})
    Comment.create({body: "asdf5", user_id: 3, meetup_id: 1})

    Membership.create({user_id: 1, meetup_id: 1})
    Membership.create({user_id: 2, meetup_id: 1})
    Membership.create({user_id: 3, meetup_id: 1})
    Membership.create({user_id: 1, meetup_id: 2})
    Membership.create({user_id: 3, meetup_id: 2})
    Membership.create({user_id: 2, meetup_id: 3})
    Membership.create({user_id: 3, meetup_id: 3})
  end
end
