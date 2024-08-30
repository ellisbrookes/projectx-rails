class CommentNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = 'CommentMailer'
    config.method = :new_comment
    config.if = -> { recipient.email_notifications? }
    config.wait = 5.minutes
  end

  notification_methods do
    def message
      "#{params[:commenter_name]} commented on #{params[:comment_task]}"
    end

    def url
      params[:commenter_url]
    end
  end
end
