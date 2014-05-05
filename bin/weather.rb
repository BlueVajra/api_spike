require 'faraday'
require 'json'
require 'dotenv'
require 'pp'
require 'date'

Dotenv.load

boulder_url ="http://openweathermap.org/data/2.5/find?q=Boulder, US&units=imperial&mode=json&APPID=#{ENV['WEATHER_APP_ID']}"

elk_rapids_7day_url ="http://openweathermap.org/data/2.5/forecast/daily?q=Elk Rapids, US&cnt=7&units=imperial&mode=json&APPID=#{ENV['WEATHER_APP_ID']}"


response = Faraday.get(boulder_url)
data = JSON.parse(response.body)
puts '*' * 30
puts "Today's forecast in Boulder"
puts '*' * 30
puts "Current Temperature of #{data['list'].first['main']['temp']} degrees"
puts "Temp: #{data['list'].first['main']['temp']}"
puts "Low: #{data['list'].first['main']['temp_min']}"
puts "High: #{data['list'].first['main']['temp_max']}"



response = Faraday.get(elk_rapids_7day_url)
data = JSON.parse(response.body)
puts " "
puts '*' * 30
puts "7 day forecast for Elk Rapids"
puts '*' * 30
data['list'].each_with_index do |day, index|
  puts "#{(Date.today+index).strftime('%D')}: (Low:#{day['temp']['min']} High:#{day['temp']['max']})"
end
