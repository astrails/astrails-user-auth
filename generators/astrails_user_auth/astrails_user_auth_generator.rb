require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")
require File.expand_path(File.dirname(__FILE__) + "/lib/rake_commands.rb")

class AstrailsUserAuthGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # controllers
      m.insert_into "app/controllers/application_controller.rb", "include Astrails::Auth::Controller"
      m.file('app/controllers/users_controller.rb', 'app/controllers/users_controller.rb')

      # routes
      m.route_resource ':profile, :controller => "users"'
      m.route_resources ':users'
      m.route_name :signup, '"/signup", :controller => "users", :action => "new"'

      m.route_resource ':user_session, :controller => "user_session"'
      m.route_name :login, '"/login", :controller => "user_session", :action => "new"'

      m.route_resources ':passwords'
      m.route_name :edit_password, "'/passwords', :controller => 'passwords', :action => 'edit', :conditions => { :method => :get }"
      m.route_name :update_password, "'/passwords', :controller => 'passwords', :action => 'update', :conditions => { :method => :put }"
      m.route_name :activate, "'/activate/:id', :controller => 'passwords', :action => 'edit'"

      # models
      m.directory File.join("app", "models")
      m.insert_or_create("app/models/user.rb", <<-RUBY)
  acts_as_authentic do
    c.validates_length_of_password_field_options =
      {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options =
      {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.perishable_token_valid_for = 2.weeks
  end
  include Astrails::Auth::Model
RUBY
      m.file('app/models/user_session.rb', 'app/models/user_session.rb')

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
      Dir[m.target.source_root+"/spec/**/*.*"].each do |file|
        incl = File.read(file).grep(/include/).first.chomp
        file = file[m.target.source_root.length+1..-1]
        m.directory File.dirname(file)
        m.insert_or_create(file, incl)
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
