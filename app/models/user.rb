class User < ActiveRecord::Base
  has_secure_password

  has_and_belongs_to_many :inviteds,
  :class_name => 'User',
  :join_table => 'invitations',
  :association_foreign_key => 'invited_id'

  has_and_belongs_to_many :inviters,
  :class_name => 'User',
  :join_table => 'invitations',
  :foreign_key => 'invited_id',
  :association_foreign_key => 'user_id'

  has_many :invitations
  
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :name, :email, :description, presence: true, length: { minimum: 2 }
  validates :password, presence: true, length: { minimum: 8 }
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false}
end
