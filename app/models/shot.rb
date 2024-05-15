class Shot < ApplicationRecord

    belongs_to :user
    has_one_attached :image
    has_many :comments , dependent: :destroy
    is_impressionable
    acts_as_votable
end
