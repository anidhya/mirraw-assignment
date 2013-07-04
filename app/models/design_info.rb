class DesignInfo < ActiveRecord::Base
  attr_accessible :designer, :name, :price
  
  belongs_to :designer
end
