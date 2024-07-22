# config/initializers/annotate.rb

Annotate.set_defaults do |config|
  config.position_in_class = "after"
  config.show_indexes = true
  config.simple_indexes = true
  config.show_foreign_keys = true
  config.show_complete_foreign_keys = true
  config.show_constraints = true
  config.show_uml = false
  config.model_dir = "app/models"
  config.include_version = false
  config.exclude_tests = false
  config.exclude_fixtures = false
  config.exclude_factories = false
  config.exclude_serializers = false
  config.exclude_scaffolds = true
  config.exclude_controllers = true
  config.exclude_helpers = true
  config.exclude_channels = true
  config.exclude_mailers = true
  config.exclude_jobs = true
  config.exclude_validators = true
  config.exclude_observers = true
  config.exclude_services = true
  config.exclude_engines = true
  config.exclude_libs = true
  config.exclude_gems = true
end
