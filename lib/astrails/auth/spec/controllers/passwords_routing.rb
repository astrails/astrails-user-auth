module Astrails
  module Auth
    module Spec
      module Controllers
        module PasswordsRouting
          def self.included(base)
            base.class_eval do
              describe "route generation" do

                it "should map { :controller => 'passwords', :action => 'index' } to /passwords" do
                  route_for(:controller => "passwords", :action => "index").should == "/passwords"
                end

                it "should map { :controller => 'passwords', :action => 'new' } to /passwords/new" do
                  route_for(:controller => "passwords", :action => "new").should == "/passwords/new"
                end

                it "should map { :controller => 'passwords', :action => 'show', :id => '1'} to /passwords/1" do
                  route_for(:controller => "passwords", :action => "show", :id => "1").should == "/passwords/1"
                end

                it "should map { :controller => 'passwords', :action => 'edit', :id => '1' } to /passwords/1/edit" do
                  route_for(:controller => "passwords", :action => "edit", :id => "1").should == "/passwords/1/edit"
                end

                it "should map { :controller => 'passwords', :action => 'update', :id => '1' } to /passwords/1" do
                  route_for(:controller => "passwords", :action => "update", :id => "1").should == {:path => "/passwords/1", :method => :put}
                end

                it "should map { :controller => 'passwords', :action => 'destroy', :id => '1' } to /passwords/1" do
                  route_for(:controller => "passwords", :action => "destroy", :id => "1").should == {:path => "/passwords/1", :method => :delete}
                end
              end

              describe "route recognition" do

                it "should generate params { :controller => 'passwords', action => 'index' } from GET /passwords" do
                  params_from(:get, "/passwords").should == {:controller => "passwords", :action => "index"}
                end

                it "should generate params { :controller => 'passwords', action => 'new' } from GET /passwords/new" do
                  params_from(:get, "/passwords/new").should == {:controller => "passwords", :action => "new"}
                end

                it "should generate params { :controller => 'passwords', action => 'create' } from POST /passwords" do
                  params_from(:post, "/passwords").should == {:controller => "passwords", :action => "create"}
                end

                it "should generate params { :controller => 'passwords', action => 'show', id => '1' } from GET /passwords/1" do
                  params_from(:get, "/passwords/1").should == {:controller => "passwords", :action => "show", :id => "1"}
                end

                it "should generate params { :controller => 'passwords', action => 'edit', id => '1' } from GET /passwords/1;edit" do
                  params_from(:get, "/passwords/1/edit").should == {:controller => "passwords", :action => "edit", :id => "1"}
                end

                it "should generate params { :controller => 'passwords', action => 'update', id => '1' } from PUT /passwords/1" do
                  params_from(:put, "/passwords/1").should == {:controller => "passwords", :action => "update", :id => "1"}
                end

                it "should generate params { :controller => 'passwords', action => 'destroy', id => '1' } from DELETE /passwords/1" do
                  params_from(:delete, "/passwords/1").should == {:controller => "passwords", :action => "destroy", :id => "1"}
                end
              end
            end
          end
        end
      end
    end
  end
end
