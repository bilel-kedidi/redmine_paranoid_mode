module RedmineParanoidMode
  module Patches
    module IssuePatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable

          # acts_as_paranoid if self.attribute_method?(:deleted_at)

          safe_attributes 'deleted_at'

          default_scope -> {where(deleted_at: nil)}

          scope :visible, lambda {|*args|
            if User.current.admin?
              unscope(where: :deleted_at)
            end
            joins(:project).
            where(Issue.visible_condition(args.shift || User.current, *args))
          }

          alias_method_chain :destroy, :no_effect
        end
      end

      module ClassMethods

      end

      module InstanceMethods

        def deleted?
          deleted_at.present?
        end

        def destroy_with_no_effect
          self.deleted_at = Time.now
          time_entries.update_all({deleted_at: Time.now})
          self.save
        end
      end
    end
  end
end

unless Issue.included_modules.include?(RedmineParanoidMode::Patches::IssuePatch)
  Issue.send(:include, RedmineParanoidMode::Patches::IssuePatch)
end

