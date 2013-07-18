module Landmark
  module Rails
    module Helpers
      extend ActiveSupport::Concern

      # Convenience function to be used as a before_filter. By setting
      # it, the current user will automatically be identified. To specify
      # traits and actions properties, use this function within a
      # before_filter block.
      def landmark_identify_and_track_page(traits={}, properties={})
        landmark_identify(traits)
        landmark_track_page(properties)
      end
      
      # Automatically identifies a user and tracks their traits.
      def landmark_identify(traits={})
        if respond_to?(:current_user) && !current_user.nil?
          Landmark::Rails.identify(current_user.id, traits)
        end
      end
      
      # Convenience function for tracking an action within a controller.
      def landmark_track(action, properties={})
        Landmark::Rails.track(action, properties)
      end

      # Convenience function for tracking a page within a controller.
      def landmark_track_page(properties={})
        Landmark::Rails.track_page(properties)
      end
    end
  end
end
