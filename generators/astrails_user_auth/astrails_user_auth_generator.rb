require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/lib/rake_commands.rb")

class AstrailsUserAuthGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # controllers
      m.insert_into "app/controllers/application_controller.rb", "include Astrails::Auth::Controller"
      m.file('app/controllers/users_controller.rb', 'app/controllers/users_controller.rb')

      # routes
      m.route_resource ':account, :controller => "users"'
      m.route_resources ':users'
      m.route_name :signup, '"/signup", :controller => "users", :action => "new"'

      m.route_resource ':user_session, :controller => "user_session"'
      m.route_name :login, '"/login", :controller => "user_session", :action => "new"'
      m.route_resources ':password_resets'

      # models
      m.directory File.join("app", "models")
      m.insert_or_create("app/models/user.rb", <<-RUBY)
  acts_as_authentic
  include Astrails::Auth::Model
RUBY

      # views
      # copy all files in the templates app/views directory
      Dir[m.target.source_root+"/app/views/**/*.*"].map{|s| s[m.target.source_root.length+1..-1]}.each do |file|
        dir = File.dirname(file)
        m.directory(dir) unless File.directory?(dir)
        m.file file, file
      end

      # migration
      m.migration_template "migrations/#{migration_name}.rb", 'db/migrate', :migration_file_name => "auth_#{migration_name}"

      # specs
      m.directory File.join("spec", "controllers")
      %w(
         password_resets_routing_spec.rb
         users_controller_spec.rb
         password_resets_controller_spec.rb
         user_session_controller_spec.rb
         users_routing_spec.rb
        ).each do |f|
        f = "spec/controllers/#{f}"
        m.insert_or_create(f, "include Astrails::Auth::Specs::#{f.split('.').first.camelize}")
      end
    end
  end
  private

  def migration_name
    if ActiveRecord::Base.connection.table_exists?(:users)
      'update_users'
    else
      'create_users'
    end
  end
end
