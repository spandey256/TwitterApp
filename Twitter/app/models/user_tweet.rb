class UserTweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :tweet, :user
end
