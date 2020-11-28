#!/usr/bin/env ruby
require 'optparse'
require 'csv'
require 'geokit'

RADIAN_MULTIPLIER = Math::PI/180
EARTH_RADIUS = 6371 # in KM
DISTANCE_CONVERTED = {
  'km' => 1,
  'mi' => 0.621371192
}

class Parser
  def self.parse(options)
    parsed_options = { units: 'mi', output: 'text' }

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage:
  ./find_store --address="<address>"
  ./find_store --address="<address>" [--units=(mi|km)] [--output=text|json]
  ./find_store --zip=<zip>
  ./find_store --zip=<zip> [--units=(mi|km)] [--output=text|json]'

      opts.on('--zip=<zip>', 'Find nearest store to this zip code. If there are multiple best-matches, return the first.') do |zip|
        if zip.nil?
          raise ArgumentError, 'Zip Code is missing!'
        else
          parsed_options[:zip] = zip
        end
      end

      opts.on('--address="<address>"', 'Find nearest store to this address. If there are multiple best-matches, return the first.') do |address|
        if address.nil?
          raise ArgumentError, 'Address is missing!'
        else
          parsed_options[:address] = address
        end
      end

      opts.on('--units=(mi|km)', 'Display units in miles or kilometers [default: mi]') do |units|
        unless ['mi', 'km'].include?(units)
          raise ArgumentError, 'Units can be either "mi" or "km"!'
        else
          parsed_options[:units] = units
        end
      end

      opts.on('--output=(text|json)', 'Output in human-readable text, or in JSON (e.g. machine-readable) [default: text]') do |output|
        unless ['text', 'json'].include?(output)
          raise ArgumentError, 'Output can be either "text" or "json"!'
        else
          parsed_options[:output] = output
        end
      end

      opts.on_tail('--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)

    parsed_options
  end
end

def config_geokit
  Geokit::Geocoders::OpencageGeocoder.key = 'd273615596284988a01cee8d1addee01'
  Geokit::Geocoders::provider_order = [:opencage]
end

def geocode_search_location(term)
  Geokit::Geocoders::MultiGeocoder.geocode(term)
end

def distance_between(location1, location2)
  # Haversine formula - Ref: https://en.wikipedia.org/wiki/Haversine_formula
  latitude1 = location1[0].to_f * RADIAN_MULTIPLIER
  longitude1 = location1[1].to_f * RADIAN_MULTIPLIER
  latitude2 = location2[0].to_f * RADIAN_MULTIPLIER
  longitude2 = location2[1].to_f * RADIAN_MULTIPLIER

  delta_latitude = latitude2 - latitude1
  delta_longitude = longitude2 - longitude1

  a = (Math.sin(delta_latitude / 2))**2 + Math.cos(latitude1) * (Math.sin(delta_longitude / 2))**2 * Math.cos(latitude2)
  c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

  c * EARTH_RADIUS
end

def find_nearest_store(stores, search_location, units = 'km')
  min_distance = Float::INFINITY
  nearest_store = {}

  stores.each do |store|
    curr_distance = distance_between([store['Latitude'], store['Longitude']], search_location)

    if curr_distance < min_distance
      # '<' ensures that the first one is not overwritten and is therefore returned, in case of a tie
      min_distance = curr_distance
      nearest_store = store.to_h
    end
  end

  min_distance *= DISTANCE_CONVERTED[units] # Convert distance to desired format

  nearest_store.merge('Distance' => min_distance)
end

def print_result(store, output_format = 'text')
  if output_format == 'json'
    p store.to_json
  else
    p "Store Name: #{store['Store Name']}, Store Location: #{store['Store Location']}, Address: #{store['Address']}, " +
    "City: #{store['City']}, State: #{store['State']}, Zip Code: #{store['Zip Code']}, Latitude: #{store['Latitude']}, " +
    "Longitude: #{store['Longitude']}, County: #{store['County']}, Distance: #{store['Distance']}"
  end
end

def find_store
  config_geokit
  options = Parser.parse ARGV

  if !options.key?(:zip) && !options.key?(:address)
    raise ArgumentError, 'Either Zip or Address must be supplied!'
  end

  search_location = geocode_search_location(options[:zip] || options[:address])

  if search_location.nil?
    raise ArgumentError, 'Unable to Geocode location'
  end

  stores = CSV.parse(File.read('data/store-locations.csv'), headers: true)
  nearest_store = find_nearest_store(stores, [search_location.latitude, search_location.longitude], options[:units])
  print_result(nearest_store, options[:output])
end

find_store
