class Designer < ActiveRecord::Base
  require "scrap"
  include Scrap
  attr_accessible :link, :name
  
  validates :link, presence: true
  validates :link, uniqueness: true
  has_many :design_infos, :dependent => :destroy
  
  def self.fetch_url(url)
    scrap_url(url)
  end
  
  def self.add_info(data)
    data.each do |link|
      create(:link => link)
    end
  end
  
  def self.parse_each_designers_data
    where(:status => 0).all.each do |record|
      data = collect_individual_designers_info(record.link)
      record.name = data[:designer_name]
      record.status = 1
      record.save
      data[:design_info].each do |design_info|
        record.design_infos.new(:name => design_info[:design_name], :price => design_info[:design_price]).save
      end
    end
  end
  
  def self.get_data
    result = {}
    includes(:design_infos).all.each do |designer|
      result[designer.name] = designer.design_infos.collect {|design_info| {:design_name => design_info.name, :design_price => design_info.price}}
    end
    result
  end
  
end
