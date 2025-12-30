class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def log_activity(action, target_type, target_name, details = nil)
    return unless current_user

    ActivityLog.create(
      user: current_user,
      action: action,
      target_type: target_type,
      target_name: target_name,
      details: details
    )
  end
end