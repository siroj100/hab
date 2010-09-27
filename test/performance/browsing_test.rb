require 'test_helper'
require 'performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionController::PerformanceTest
  def test_list_of_people
    get '/people'
  end
  
  def test_list_of_person_addresses
    get '/people/1'
  end
end
