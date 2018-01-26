class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



class Desc
	def initialize(title, aac)
		@title = title
    @aac = aac
	end
	attr_reader :title
  attr_reader :aac
end


  def bomscraper
    require 'open-uri'
    doc = Nokogiri::HTML(open("ftp://ftp.bom.gov.au/anon/gen/fwo/IDV10753.xml"))

    locations = doc.xpath('//area[@type="location"]/@description')
    aacs = doc.xpath('//area[@type="location"]/@aac')
    @descArray = []



temp_array_locations = []
locations.each do |l|
temp_array_locations = temp_array_locations + [l.text]
end 


temp_array_aac = []
aacs.each do |a|
temp_array_aac = temp_array_aac + [a.text]
end 


numbers = Array (0..(temp_array_aac.length()-1)) # don't forget to subtract one for Ruby indexing starting at 0


for number in numbers do

title = temp_array_locations[number]
aac = temp_array_aac[number]

@descArray << Desc.new(title, aac)
 


    end

    render template: 'bomscraper'
  end






end
