# == Schema Information
#
# Table name: television_programs
#
#  id         :integer          not null, primary key
#  program    :string
#  level_1    :string
#  level_2    :string
#  cost       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :integer
#  start_time :integer
#  end_time   :integer
#  duration   :integer
#  st_video   :integer
#  et_video   :integer
#  video      :string
#
# Indexes
#
#  index_television_programs_on_channel_id  (channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#

require 'test_helper'

class TelevisionProgramTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
