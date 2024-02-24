# To deliver this notification:
#
# NewComment.with(record: @post, message: "New post").deliver(User.all)

class CommentNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  deliver_by :email do |config|
    config.mailer = "UserMailer"
    config.method = "new_comment"
    config.params = ->(recipient) { {user: recipient} }
    config.wait = 5.minutes
  end
  
  notification_methods do
    def message
      "This is #{recipient.full_name}'s foo: #{params[:foo]}"
    end
  end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end