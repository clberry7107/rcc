class HomeController < ApplicationController
   before_action :authenticate_user!
   
   def index
      @newreleases = Newrelease.all 
   end
    
end