class HomeController < ApplicationController
   
   def index
      @newreleases = Newrelease.all 
   end
    
end