class Router < ActiveRecord::Base
  require "openssl"
  # This is the Global Encryption string
  before_save :encrypt_community_string

  def encrypt_community(community)
    cipher = OpenSSL::Cipher::AES.new(128, :CBC)
    cipher.encrypt
    key = cipher.random_key
    iv = cipher.random_iv

    encrypted = cipher.update(community) + cipher.final

    return_hash = {encrypted: %Q[#{encrypted}].force_encoding('UTF-8'), key: %Q[#{key}].force_encoding('UTF-8'), iv: %Q[#{iv}].force_encoding('UTF-8')}
  end

  def decrypt_community(encrypted_community, key, iv)
    decipher = OpenSSL::Cipher::AES.new(128, :CBC)
    decipher.decrypt
    decipher.key = key
    decipher.iv = iv

    plain = decipher.update(encrypted_community) + decipher.final
    
  end

  def encrypt_community_string
    unless self.community.blank?
      if self.key.blank? || self.iv.blank? 
        # We need to add the encryption
        encryption_hash = encrypt_community(self.community)
        self.community = encryption_hash[:encrypted]
        self.key = encryption_hash[:key]
        self.iv = encryption_hash[:iv]
      end
    else
      # raise error
      raise self.error
    end

  end


end
