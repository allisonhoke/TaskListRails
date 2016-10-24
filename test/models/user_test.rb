require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @auth_hash = {
      provider: 'github',
      uid: '123545',
      'info' => { 'email' => "a@b.com", 'name' => "Ada" }
      }
  end

  test "builds a user when provided valid input" do
    a = User.build_from_github(@auth_hash)

    assert a.valid?
  end

  test "doesn't build a user when email is missing" do
    b = User.build_from_github({uid: '123456', 'info' => {'name' => "Allison"}})

    assert_not b.valid?
  end

  test "doesn't build a user when uid is missing" do
    c = User.build_from_github({'info' => {'name' => "Allison", 'email' => "a@b.com"}})

    assert_not c.valid?
  end
end
