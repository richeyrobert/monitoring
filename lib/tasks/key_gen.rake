namespace :key_gen do
  require 'openssl'
  desc "Generate 256-bit AES key"
  task generate: :environment do
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    puts "Cipher Random Key:"
    puts cipher.random_key.inspect
    puts "Cipher Random IV:"
    puts cipher.random_iv.inspect
    puts "Please copy and paste these keys into their respective places in the config/initializers/router_encryption.rb file."
  end

end