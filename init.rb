require 'redmine'
require_dependency 'redmine_issue_reminder/mailer_patch'

Redmine::Plugin.register :redmine_issue_reminder do
  name 'Redmine Issue Reminder plugin'
  author 'L'
  description 'Sends email reminders for issues that have not been updated recently'
  version '0.1.0'
  url 'https://github.com/KeKkEmEn/redmine_issue_reminder'
  author_url 'https://github.com/KeKkEmEn'

  settings default: {
    'reminder_days' => 7,
    'reminder_text' => 'This issue has not been updated for a while. Please update the status or add a comment.',
    'reminder_roles' => []
  }, partial: 'settings/issue_reminder_settings'

  project_module :issue_reminder do
    permission :view_issue_reminder, issue_reminder: :index
    permission :send_issue_reminder, issue_reminder: :send_reminders
  end

  menu :project_menu, :issue_reminder, 
       { controller: 'issue_reminder', action: 'index' }, 
       caption: :label_issue_reminder, 
       after: :issues, 
       param: :project_id
end
