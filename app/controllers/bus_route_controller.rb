class BusRouteController < ApplicationController
  require 'rexml/document'
  require 'net/http'
  def index

  end

  def to_home
    @times_1 = NextMuni.get_times('30x', 5336)
    @times_2 = NextMuni.get_times('41', 5336)

    @times_1 = ["No current predictions"] if @times_1.empty? 
     @times_2 = ["No current predictions"]if @times_2.empty?
  end

  def to_work
    @franklin_30 = NextMuni.get_times('30x', 3944)
    @franklin_41 = NextMuni.get_times('41', 6787)
    @franklin_45 = NextMuni.get_times('45', 6787)

    @laguna_30 = NextMuni.get_times('30x', 3948)
    @laguna_41 = NextMuni.get_times('41', 6771)
    @laguna_45 = NextMuni.get_times('45', 6771)

    @franklin_30 = ["No current predictions"] if @franklin_30.empty?
    @franklin_41 = ["No current predictions"] if @franklin_41.empty?
    @franklin_45 = ["No current predictions"] if @franklin_45.empty?
    @laguna_30 = ["No current predictions"] if @laguna_30.empty?
    @laguna_41 = ["No current predictions"] if @laguna_41.empty?
    @laguna_45 = ["No current predictions"] if @laguna_45.empty?
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
