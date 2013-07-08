module Landmark
  module Rails
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :landmark
      end

      module ClassMethods
        def landmark
          before_filter :landmark_identify_and_track
        end
      end

      def landmark_identify_and_track
        if respond_to?(:current_user) && !current_user.nil?
          Landmark::Rails.identify(current_user.id)
        end
        
        action = request.path
        action = Landmark::Rails.normalize_path(action) if Landmark::Rails.normalize_paths?
        Landmark::Rails.track(action)
      end
    end
  end
end
