Rabarber.configure do |config|
  config.cache_enabled = true
  config.current_user_method = :current_user
  config.must_have_roles = false
  config.when_actions_missing = -> (missing_actions, context) { ... }
  config.when_roles_missing = -> (missing_roles, context) { ... }
  config.when_unauthorized = -> (controller) { ... }
end
