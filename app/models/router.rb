class Router < ActiveRecord::Base
  require "openssl"
  # This is the Global Encryption string
  before_save :encrypt_community_string

  def encrypt(plain_data)
      cipher = OpenSSL::Cipher::AES.new(256, :CBC)
      cipher.encrypt
      cipher.key = Rails.application.config.aes_master_key
      cipher.iv = Rails.application.config.aes_master_iv
      encrypted = cipher.update(plain_data) + cipher.final
      encoded = Base64.encode64(encrypted).encode('utf-8')
    end

    def decrypt_community
      decipher = OpenSSL::Cipher::AES.new(256, :CBC)
      decipher.decrypt
      decipher.key = Rails.application.config.aes_master_key
      decipher.iv = Rails.application.config.aes_master_iv
      decoded = Base64.decode64 self.community.encode('ascii-8bit')
      plain = decipher.update(decoded) + decipher.final
    end

  def encrypt_community_string
    unless self.community.blank?
      # We need to add the encryption
      self.community = encrypt(self.community)
    else
      # raise error
      raise self.error
    end

  end


end
