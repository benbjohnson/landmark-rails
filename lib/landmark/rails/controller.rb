module Landmark
  module Rails
    module Helpers
      extend ActiveSupport::Concern

      # Disables tracking for this request.
      def disable_landmark()
        Landmark::Rails.enabled = false
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
      def landmark_track_page_view(properties={})
        Landmark::Rails.track_page_view(properties)
      end
    end
  end
end
