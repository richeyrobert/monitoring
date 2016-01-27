class Mapping < ActiveRecord::Base
  belongs_to :mapping_type
  before_save :downcase_all

  def downcase_all
    # this will convert the field of the received_text field to all downcase so that we can probe the data easier.
    self.received_text = self.received_text.downcase
  end
end
