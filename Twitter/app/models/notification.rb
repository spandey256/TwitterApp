class Notification < ActiveRecord::Base
  belongs_to :to, :class_name => "User"
  belongs_to :from, :class_name => "User"
  attr_accessible :type
end
