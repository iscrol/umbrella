require "dotenv/load"
require "json"
require "http"

pp "Where do thou resideith?"
user_location = gets
google_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=" + ENV.fetch("GOOGLE_MAPS_API")

google_raw_response = HTTP.get(google_url)
google_parsed_response = JSON.parse(google_raw_response)
google_result = google_parsed_response["results"][0]["geometry"]["location"]
lat = google_result["lat"]
lng = google_result["lng"]

pirate_weather_url = "https://api.pirateweather.net/forecast/" + ENV.fetch("PIRATE_WEATHER_KEY") + "/" + lat.to_s + "," + lng.to_s

pirate_weather_raw_response = HTTP.get(pirate_weather_url)
pirate_parsed_response = JSON.parse(pirate_weather_raw_response)
currently = pirate_parsed_response["currently"]
temp = currently["temperature"]

pp "It is " + temp.to_s + " degrees right now."
