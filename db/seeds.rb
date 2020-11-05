# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first
User.create(email: "foo@example.com",
            password: "123qweASD",
            password_confirmation: "123qweASD",
            confirmed_at: Time.current,
            admin: true)

Conference.create(
    title: "TestFest",
    email: "foo@example.com",
    host_name: "clarion.openfest.test",
    description: "Test Conference",
    start_date: Date.today,
    end_date: Date.today,
    planned_cfp_end_date: Date.today.prev_day
)