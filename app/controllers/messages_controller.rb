class MessagesController < ApplicationController
    before_action :find_conversation
    before_action :validates

    def index
      @messages = @conversation.messages

      if @messages.length > 6
        @over_ten = true
        @messages = @messages[-6..-1]
      end

      if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end

      @message = @conversation.messages.new
    end
    
    def create
      @message = @conversation.messages.new(message_params)  
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      end
    end
    
    def new
      @message = @conversation.messages.new
    end

    private

    def message_params
      params.require(:message).permit(:body, :user_id)
    end

    def find_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def validates
      if @conversation.sender_id == current_user.id || @conversation.recepient_id == current_user.id
        redirect_to conversation_messages_path(@conversation)
      else
        redirect_to root_path
      end
    end
end