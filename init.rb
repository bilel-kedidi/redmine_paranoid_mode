Redmine::Plugin.register :redmine_paranoid_mode do
  name 'Redmine Paranoid Mode plugin'
  author 'Maria Syczewska'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/efigence/redmine_paranoid_mode'
  author_url 'https://github.com/efigence'
end

ActionDispatch::Callbacks.to_prepare do
  require 'redmine_paranoid_mode/patches/application_controller_patch'
  require 'redmine_paranoid_mode/patches/issue_patch'
  require 'redmine_paranoid_mode/patches/time_entry_patch'
  require 'redmine_paranoid_mode/patches/attachment_patch'
  require 'redmine_paranoid_mode/patches/issue_query_patch'
end
