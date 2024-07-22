# lib/tasks/auto_annotate_models.rake
if defined?(Annotate)
  namespace :db do
    task :migrate => :environment do
      Rake::Task['annotate'].invoke
    end
  end

  Annotate.set_defaults({
    'position_in_class' => 'after',
    'position_in_test' => 'after',
    'show_indexes' => 'true',
    'show_foreign_keys' => 'true'
  })

  Annotate.load_tasks
end
