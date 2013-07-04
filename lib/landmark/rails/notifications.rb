# Clears the Landmark tracking data before every request.
ActiveSupport::Notifications.subscribe("start_processing.action_controller") do |*args|
  Landmark::Rails.clear()
end

# Clears the Landmark tracking data after every request.
ActiveSupport::Notifications.subscribe("process_action.action_controller") do |*args|
  Landmark::Rails.clear()
end

