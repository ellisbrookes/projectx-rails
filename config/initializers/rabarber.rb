Rabarber.configure do |config|
  config.cache_enabled = true
  config.current_user_method = :current_user
  config.must_have_roles = false

  config.when_actions_missing = -> (missing_actions, context) do
    raise ActionController::RoutingError.new('Not Found')
  end

  config.when_roles_missing = -> (missing_roles, context) do
    redirect_to root_path, alert: 'You do not have sufficient permissions'
  end

  config.when_unauthorized = -> (controller) do
    redirect_to root_path, alert: 'You are not authorized to access this page'
  end
end
