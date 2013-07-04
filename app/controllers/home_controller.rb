require "Scrap"

class HomeController < ApplicationController
  include Scrap
  def index
    
  end
  
  def parse
    result = scrap_url("http://www.mirraw.com/designers")
    puts result
    data = render_to_string(:partial => 'scrap_data', :layout => false, 
                     :locals => {:data => result})
    render :json => {:data => data}
  end
  
end
