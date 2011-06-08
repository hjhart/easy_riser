class BusRouteController < ApplicationController
  require 'rexml/document'
  require 'net/http'
  def index

  end

  def custom

    @times_1 = NextMuni.get_times('30x', 5336)
    @times_2 = NextMuni.get_times('41', 5336)

    @times_1 = ["No current predictions"] if @times_1.empty? 
     @times_2 = ["No current predictions"]if @times_2.empty?

  end

  def pick_stop
    @stops = MuniHelper.get_stops(xml)
  end

  def show
    url = MuniHelper.build_url(params[:route_id], params[:stop_id])
    xml = Net::HTTP.get(URI.parse(url))
    @predictions = MuniHelper.get_times(xml)
  end

end
