# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  message    :string
#  category   :string
#  read       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end