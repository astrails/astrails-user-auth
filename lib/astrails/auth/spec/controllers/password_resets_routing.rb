module Astrails
  module Auth
    module Spec
      module Controllers
        module PasswordResetsRouting
          def self.included(base)
            base.class_eval do
              describe "route generation" do

                it "should map { :controller => 'password_resets', :action => 'index' } to /password_resets" do
                  route_for(:controller => "password_resets", :action => "index").should == "/password_resets"
                end

                it "should map { :controller => 'password_resets', :action => 'new' } to /password_resets/new" do
                  route_for(:controller => "password_resets", :action => "new").should == "/password_resets/new"
                end

                it "should map { :controller => 'password_resets', :action => 'show', :id => '1'} to /password_resets/1" do
                  route_for(:controller => "password_resets", :action => "show", :id => "1").should == "/password_resets/1"
                end

                it "should map { :controller => 'password_resets', :action => 'edit', :id => '1' } to /password_resets/1/edit" do
                  route_for(:controller => "password_resets", :action => "edit", :id => "1").should == "/password_resets/1/edit"
                end

                it "should map { :controller => 'password_resets', :action => 'update', :id => '1' } to /password_resets/1" do
                  route_for(:controller => "password_resets", :action => "update", :id => "1").should == {:path => "/password_resets/1", :method => :put}
                end

                it "should map { :controller => 'password_resets', :action => 'destroy', :id => '1' } to /password_resets/1" do
                  route_for(:controller => "password_resets", :action => "destroy", :id => "1").should == {:path => "/password_resets/1", :method => :delete}
                end
              end

              describe "route recognition" do

                it "should generate params { :controller => 'password_resets', action => 'index' } from GET /password_resets" do
                  params_from(:get, "/password_resets").should == {:controller => "password_resets", :action => "index"}
                end

                it "should generate params { :controller => 'password_resets', action => 'new' } from GET /password_resets/new" do
                  params_from(:get, "/password_resets/new").should == {:controller => "password_resets", :action => "new"}
                end

                it "should generate params { :controller => 'password_resets', action => 'create' } from POST /password_resets" do
                  params_from(:post, "/password_resets").should == {:controller => "password_resets", :action => "create"}
                end

                it "should generate params { :controller => 'password_resets', action => 'show', id => '1' } from GET /password_resets/1" do
                  params_from(:get, "/password_resets/1").should == {:controller => "password_resets", :action => "show", :id => "1"}
                end

                it "should generate params { :controller => 'password_resets', action => 'edit', id => '1' } from GET /password_resets/1;edit" do
                  params_from(:get, "/password_resets/1/edit").should == {:controller => "password_resets", :action => "edit", :id => "1"}
                end

                it "should generate params { :controller => 'password_resets', action => 'update', id => '1' } from PUT /password_resets/1" do
                  params_from(:put, "/password_resets/1").should == {:controller => "password_resets", :action => "update", :id => "1"}
                end

                it "should generate params { :controller => 'password_resets', action => 'destroy', id => '1' } from DELETE /password_resets/1" do
                  params_from(:delete, "/password_resets/1").should == {:controller => "password_resets", :action => "destroy", :id => "1"}
                end
              end
            end
          end
        end
      end
    end
  end
end
