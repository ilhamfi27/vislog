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

class Notification < ActiveRecord::Base

  def self.count_has_not_read_notifications
    Notification.where(read: false).count
  end

  def self.has_not_read_notifications
    Notification.where(read: false).order(created_at: :desc)
  end
end
