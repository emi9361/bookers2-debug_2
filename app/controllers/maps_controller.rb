class MapsController < ApplicationController
  def index
  end

  def map
  	results = Geocoder.search(params[:address])
    @latlng = results.first.coordinates
  	#map.js.erbで経度情報が入った@latlngを使える

  	respond_to do |format|
  	 format.js
  	end
  end
end