require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "name not empty" do 
    hash = OpenSSL::Digest::MD5.new(Time.new.strftime('%c')).hexdigest[0..12]
                                    
    user = User.new
    user.email = hash << '@dev.fidobakku.com'
    #user.role = 'admin'
    user.save
    
    assert user.save, 'Saved the user'
  end
  
end
