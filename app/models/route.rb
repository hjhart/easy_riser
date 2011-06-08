class Route < ActiveRecord::Base
  require 'rexml/document'

  validates_presence_of :name

  def self.get_stops(route)
    url = ::MuniHelper.build_url(route)
    xml = Net::HTTP.get(URI.parse(url))
    doc = REXML::Document.new(xml)
    stops = {}
    doc.elements.each('body/route/stop') do |ele|
      stops[ele.attributes['tag']] = ele.attributes['title']
    end
    stops
  end

  def self.get_times(route_no, stop_no)
    url = ::MuniHelper.build_url(route_no, stop_no)
    xml = Net::HTTP.get(URI.parse(url))

    doc = REXML::Document.new(xml)
    times = []
    doc.elements.each('body/predictions/direction/prediction') do |time|
      times << time.attributes['minutes']
    end
    times
  end

end
