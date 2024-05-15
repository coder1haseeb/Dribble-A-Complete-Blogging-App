class Conversation < ApplicationRecord
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :recepient, class_name: 'User', foreign_key: 'recepient_id'
    # belongs_to :user

    has_many :messages

    validates_uniqueness_of :sender_id, scope: :recepient_id

    scope :between, -> (sender_id , recepient_id) do
        where("(conversations.sender_id = ? AND conversations.recepient_id = ? ) OR (conversations.sender_id = ? AND conversations.recepient_id = ?)" , sender_id, recepient_id,recepient_id, sender_id)
    end

end
