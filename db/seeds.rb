# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')

User.create({provider: "abc", uid: "testuid", username: "testusername", email: "testemail@test.com", avatar_url: "testav_url"})
User.create({provider: "def", uid: "testuid2", username: "testusername2", email: "testemail2@test.com", avatar_url: "testav_url2"})
User.create({provider: "ghi", uid: "testuid3", username: "testusername3", email: "testemail3@test.com", avatar_url: "testav_url3"})

Meetup.create({name: "test1", description: "descript1", location: "boston1", creator_id: 1})
Meetup.create({name: "test2", description: "descript2", location: "boston2", creator_id: 2})
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
