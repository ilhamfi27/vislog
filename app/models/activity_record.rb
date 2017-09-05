# == Schema Information
#
# Table name: activity_records
#
#  id         :integer          not null, primary key
#  username   :string
#  note       :string
#  user_ip    :string
#  browser    :string
#  controller :string
#  action     :string
#  params     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ActivityRecord < ActiveRecord::Base
end
