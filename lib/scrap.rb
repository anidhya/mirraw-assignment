require 'open-uri'
require 'nokogiri'

module Scrap
  module ClassMethods
    
    def scrap_url(url)
      doc = Nokogiri::HTML(open(url.to_s))
      links = designers_links(doc)
      # collect_designers_info(links)
    end
  
    def designers_links(doc)
      puts "Scrapping the designers page"
      result = doc.css("div#main_page_content div.span-24 div.designers_pane div.designer_pane.clearfix div.span-5 div.designer_about a").map { |link| link['href'] if link.text.strip != '...More' }.compact
      result
    end
  
    def collect_designers_info(links)
      result = {}
      puts "Scrapping each designers link"
      links.each do |link|
        puts "link -> #{link.to_s}"
        doc = Nokogiri::HTML(open("http://www.mirraw.com" + link.to_s))
        first_three_listings = doc.css("div#catalog ul.listings.show_designs li.listing-card").first(3)
        result[doc.at_css("div#master_image h1").text] = 
        first_three_listings.collect do |list|
          {:design_name => list.at_css("div.listing-detail p.listing-title a span").text.delete("\n"), :design_price => (list.at_css("span.listing-price span") || list.at_css("span.discount-listing-price span")).text}
        end
      end
      result
    end
  
    def collect_individual_designers_info(link)
      puts "parsing link -> #{link.to_s}"
      result = {}
      doc = Nokogiri::HTML(open("http://www.mirraw.com" + link.to_s))
      first_three_listings = doc.css("div#catalog ul.listings.show_designs li.listing-card").first(3)
      result[:designer_name] = doc.at_css("div#master_image h1").text
      result[:design_info] = 
      first_three_listings.collect do |list|
        {:design_name => list.at_css("div.listing-detail p.listing-title a span").text.delete("\n"), :design_price => (list.at_css("span.listing-price span") || list.at_css("span.discount-listing-price span")).text}
      end
      puts result
      result
    end    
    
  end
  
  def self.included(receiver)
      receiver.extend ClassMethods
  end
    
end