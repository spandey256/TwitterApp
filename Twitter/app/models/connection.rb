class Connection < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :following, :class_name => "User"
  # attr_accessible :title, :body
end
