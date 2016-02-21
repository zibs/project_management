class DiscussionsMailer < ApplicationMailer
  def notify_discussion_owner(comment)
    @comment = comment
    @discussion = comment.discussion
    @owner = @discussion.user
    mail(to: @owner.email, subject: "A comment has been added!")
  end
end
