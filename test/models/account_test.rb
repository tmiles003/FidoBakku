require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create account" do 
    hash = OpenSSL::Digest::MD5.new(Time.new.strftime('%c')).hexdigest[0..12]
                                    
    account = Account.new
    account.email = hash << '@dev.fidobakku.com'
    
    assert account.save, 'Saved the account'
  end
  
end
