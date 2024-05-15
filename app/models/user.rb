class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shots , dependent: :destroy
  has_one_attached :image
  has_many :comments , dependent: :destroy
  # has_many :conversations , dependent: :destroy
  acts_as_voter
  followability

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end
end
