class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:sender_id], params[:recepient_id]).present?
      @conversation = Conversation.between(params[:sender_id] , params[:recepient_id]).first
    else
      @conversation = Conversation.create!(sender_id: params[:sender_id], recepient_id: params[:recepient_id])
    end
  
    unless @conversation.persisted?
      @conversation.save
    end
    redirect_to conversation_messages_path(@conversation)
  end
  
  private

  # def conversation_params
  #   .permit(:sender_id, :recepient_id)
  # end
end
