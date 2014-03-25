module UsersHelper
  
  def gen_random_password
    hash = OpenSSL::Digest::MD5.new(Time.new.strftime('%c') << Rails.configuration.secret_key_base)
    
    hash.hexdigest[0..12]
  end
  
end
