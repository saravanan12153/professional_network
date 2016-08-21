class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :invited, :class_name => "User"
end
