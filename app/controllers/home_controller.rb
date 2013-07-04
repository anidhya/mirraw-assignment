class HomeController < ApplicationController

  def index
    
  end
  
  def parse
    result = Designer.fetch_url("http://www.mirraw.com/designers")
    Designer.add_info(result)
    Designer.parse_each_designers_data
    result = Designer.get_data
    data = render_to_string(:partial => 'scrap_data', :layout => false, 
                     :locals => {:data => result})
    render :json => {:data => data}
  end
  
end
