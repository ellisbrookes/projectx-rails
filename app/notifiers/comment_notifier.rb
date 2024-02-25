class CommentNotifier < ApplicationNotifier
  deliver_by :email do |config|
    config.mailer = 'CommentMailer'
    config.method = :new_comment
    config.if = ->{ recipient.email_notifications? }
    config.wait = 5.minutes
  end

  notification_methods do
    def message
      "#{params[:commenter_name]} commented on <a href='#{company_team_project_task_path(params[:task_id])}'>#{params[:comment_task]}</a>".html_safe
    end
  end
end
