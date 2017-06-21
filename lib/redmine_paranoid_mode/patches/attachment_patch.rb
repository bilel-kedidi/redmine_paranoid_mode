module RedmineParanoidMode
  module Patches
    module AttachmentPatch
      def self.included(base)
        base.class_eval do
          unloadable

          def container
            return Issue.unscoped.find_by_id container_id  if User.current.admin? && container_type == 'Issue'
            super
          end
        end
      end
    end
  end
end

unless Attachment.included_modules.include?(RedmineParanoidMode::Patches::AttachmentPatch)
  Attachment.send(:include, RedmineParanoidMode::Patches::AttachmentPatch)
end

