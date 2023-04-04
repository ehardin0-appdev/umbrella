p "Where are you located?"

# user_location = gets.chomp

# p "Checking the weather at " + user_location + "...."

user_location = "Denver" # delete at end

p user_location # delete at end

gmaps_token = ENV.fetch("GMAPS_KEY")

gmaps_api_endpoint = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_token}"

require "open-uri"

raw_map = URI.open(gmaps_api_endpoint).read

require "json"

parsed_map = JSON.parse(raw_map)

results_array = parsed_map.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

coordinates = latitude.to_s + "," + longitude.to_s

# "Your coordinates are " + coordinates

weather_token = ENV.fetch("PIRATE_WEATHER_KEY")

weather_api_endpoint = "https://api.pirateweather.net/forecast/#{weather_token}/#{coordinates}"

raw_weather = URI.open(weather_api_endpoint).read

parsed_weather = JSON.parse(raw_weather)

parsed_weather.keys

currently_array = parsed_weather.fetch("currently")

current_temp = currently_array.fetch("temperature")

p "It is currently " + current_temp.to_s + " degrees F."

hourly_array = parsed_weather.fetch("hourly")

data_array = hourly_array.fetch("data")

hour_data_array = data_array.at(0)

hourly_summary = hour_data_array.fetch("summary")

p "Next Hour: Possible " + hourly_summary + "."


hourly_array = parsed_weather.fetch("hourly")

data_array = hourly_array.fetch("data")

hour_data_array = data_array.at(0)

hourly_temp = hour_data_array.fetch("precipProbability")

12.times do |hour|
  at_hour_array = data_array.at(hour)
  hourly_precip_prob = at_hour_array.fetch("precipProbability")

  if hourly_precip_prob > 0.1
    p "In " + hour.to_s + " hours from now, the probability of precipitation is " + hourly_precip_prob.to_s + "."
  end
end




# Interact with Pirate Weather API
# Assemble the correct endpoint
