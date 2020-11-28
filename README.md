# Find Store
This is a command line application built using Ruby to to locate the nearest store (as the vrow flies) from
store-locations.csv, print the matching store address, as well as the distance to that store.
  
# Details:
- Program is written in Ruby and requires it to be installed to be able to run it.
- Program requires at least address or zip as an argument to find the nearest store. 
- If both address and zip are passed, it returns nearest store based on zip.
- Supplied address or zip is geocoded using Opencage. For details: https://opencagedata.com/tutorials/geocode-in-ruby
- Opencage account used in this project is on Free Trial plan and allows 2,500 API requests / day.
- It computes distance between search location and all the stores in store-locations.csv, and returns a store with the shortest distance. 
- If there are more than 1 shortest then it returns the first store found from the csv file.
- To calculate distance, it uses Haversine formula - Ref: https://en.wikipedia.org/wiki/Haversine_formula

# Setup:
- Clone this repo locally.
- Install gem geokit using `gem install geokit` Ref: https://github.com/geokit/geokit
- Make sure Ruby is available and its version is 2.6.3 or above. To check Ruby version `ruby -v`
- Run program as detailed in Usage section below.

# Usage:
```
./find_store --address="<address>"
./find_store --address="<address>" [--units=(mi|km)] [--output=text|json]
./find_store --zip=<zip>
./find_store --zip=<zip> [--units=(mi|km)] [--output=text|json]
```

# Options:
```
--zip=<zip>            Find nearest store to this zip code. If there are multiple best-matches, return the first.
--address="<address>"  Find nearest store to this address. If there are multiple best-matches, return the first.
--units=(mi|km)        Display units in miles or kilometers [default: mi]
--output=(text|json)   Output in human-readable text, or in JSON (e.g. machine-readable) [default: text]
```

# Example
```
./find_store --address="1770 Union St, San Francisco, CA 94123"
./find_store --zip=94115 --units=km
```

# Test
```
ruby ./test/test_find_store.rb
```

# Errors
- Argument Error - if neither address not zip are passed
- Argument Error - if argument is used but values are not passed in
- Argument Error - if argument units has value other then mi or km
- Argument Error - if argument output has value other then text or json
- Argument Error - if unable to geocode search location
