require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "it should be create" do 
  	user = User.new(email: 'dungth@hpu.edu.vn', password: '12345678', password_confirmation: '12345678')
  	assert user.save
  end
end
