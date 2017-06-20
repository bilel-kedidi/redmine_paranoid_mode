
module RedmineParanoidMode
  module Patches
    module TimeEntryPatch
      def self.included(base)
        base.class_eval do
          unloadable

          # acts_as_paranoid if self.attribute_method?(:deleted_at)

          safe_attributes 'deleted_at'
          default_scope -> {where(deleted_at: nil)}

        end
      end
    end
  end
end

unless TimeEntry.included_modules.include?(RedmineParanoidMode::Patches::TimeEntryPatch)
  TimeEntry.send(:include, RedmineParanoidMode::Patches::TimeEntryPatch)
end

