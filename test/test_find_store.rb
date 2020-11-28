require 'test/unit'
require 'json'

class TestFindStore < Test::Unit::TestCase
  def test_find_store_with_address
    expected_result = 'Store Name: Sunnyvale, Store Location: SEC S Mathilda Ave & W McKinley Ave, Address: 298 W McKinley Ave, City: Sunnyvale, State: CA, Zip Code: 94086-6193, Latitude: 37.3737701, Longitude: -122.032323, County: Santa Clara County, Distance: 0.4066756589217706'
    actual_result = `./find_store --address="Sunnyvale, CA 94086"`
    assert_match expected_result, actual_result
  end

  def test_find_store_with_address_mi_text
    expected_result = 'Store Name: Sunnyvale, Store Location: SEC S Mathilda Ave & W McKinley Ave, Address: 298 W McKinley Ave, City: Sunnyvale, State: CA, Zip Code: 94086-6193, Latitude: 37.3737701, Longitude: -122.032323, County: Santa Clara County, Distance: 0.4066756589217706'
    actual_result = `./find_store --address="Sunnyvale, CA 94086" --units=mi --output=text`
    assert_match expected_result, actual_result
  end

  def test_find_store_with_address_km_text
    expected_result = 'Store Name: Sunnyvale, Store Location: SEC S Mathilda Ave & W McKinley Ave, Address: 298 W McKinley Ave, City: Sunnyvale, State: CA, Zip Code: 94086-6193, Latitude: 37.3737701, Longitude: -122.032323, County: Santa Clara County, Distance: 0.6544810318817783'
    actual_result = `./find_store --address="Sunnyvale, CA 94086" --units=km --output=text`
    assert_match expected_result, actual_result
  end

  def test_find_store_with_address_mi_json
    expected_result = "{\"Store Name\":\"Sunnyvale\",\"Store Location\":\"SEC S Mathilda Ave & W McKinley Ave\",\"Address\":\"298 W McKinley Ave\",\"City\":\"Sunnyvale\",\"State\":\"CA\",\"Zip Code\":\"94086-6193\",\"Latitude\":\"37.3737701\",\"Longitude\":\"-122.032323\",\"County\":\"Santa Clara County\",\"Distance\":0.4066756589217706}"
    actual_result = `./find_store --address="Sunnyvale, CA 94086" --units=mi --output=json`
    assert_match expected_result, JSON.parse(actual_result)
  end

  def test_find_store_with_address_km_json
    expected_result = "{\"Store Name\":\"Sunnyvale\",\"Store Location\":\"SEC S Mathilda Ave & W McKinley Ave\",\"Address\":\"298 W McKinley Ave\",\"City\":\"Sunnyvale\",\"State\":\"CA\",\"Zip Code\":\"94086-6193\",\"Latitude\":\"37.3737701\",\"Longitude\":\"-122.032323\",\"County\":\"Santa Clara County\",\"Distance\":0.6544810318817783}"
    actual_result = `./find_store --address="Sunnyvale, CA 94086" --units=km --output=json`
    assert_match expected_result, JSON.parse(actual_result)
  end

  def test_find_store_with_zip
    expected_result = 'Store Name: San Francisco Central, Store Location: SEC 4th & Mission St, Address: 789 Mission St, City: San Francisco, State: CA, Zip Code: 94103-3132, Latitude: 37.7847358, Longitude: -122.4036914, County: San Francisco County, Distance: 0.8177160684806529'
    actual_result = `./find_store --zip=94103`
    assert_match expected_result, actual_result
  end

  def test_find_store_with_zip_mi_text
    expected_result = 'Store Name: San Francisco Central, Store Location: SEC 4th & Mission St, Address: 789 Mission St, City: San Francisco, State: CA, Zip Code: 94103-3132, Latitude: 37.7847358, Longitude: -122.4036914, County: San Francisco County, Distance: 0.8177160684806529'
    actual_result = `./find_store --zip=94103 --units=mi --output=text`
    assert_match expected_result, actual_result
  end

  def test_find_store_with_zip_km_text
    expected_result = 'Store Name: San Francisco Central, Store Location: SEC 4th & Mission St, Address: 789 Mission St, City: San Francisco, State: CA, Zip Code: 94103-3132, Latitude: 37.7847358, Longitude: -122.4036914, County: San Francisco County, Distance: 1.3159864490155715'
    actual_result = `./find_store --zip=94103 --units=km --output=text`
    assert_match expected_result, actual_result
  end

  def test_find_store_with_zip_mi_json
    expected_result = "{\"Store Name\":\"San Francisco Central\",\"Store Location\":\"SEC 4th & Mission St\",\"Address\":\"789 Mission St\",\"City\":\"San Francisco\",\"State\":\"CA\",\"Zip Code\":\"94103-3132\",\"Latitude\":\"37.7847358\",\"Longitude\":\"-122.4036914\",\"County\":\"San Francisco County\",\"Distance\":0.8177160684806529}"
    actual_result = `./find_store --zip=94103 --units=mi --output=json`
    assert_match expected_result, JSON.parse(actual_result)
  end

  def test_find_store_with_zip_km_json
    expected_result = "{\"Store Name\":\"San Francisco Central\",\"Store Location\":\"SEC 4th & Mission St\",\"Address\":\"789 Mission St\",\"City\":\"San Francisco\",\"State\":\"CA\",\"Zip Code\":\"94103-3132\",\"Latitude\":\"37.7847358\",\"Longitude\":\"-122.4036914\",\"County\":\"San Francisco County\",\"Distance\":1.3159864490155715}"
    actual_result = `./find_store --zip=94103 --units=km --output=json`
    assert_match expected_result, JSON.parse(actual_result)
  end
end
