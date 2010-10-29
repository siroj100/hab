module HelperMethods
  # Put here any helper method you need to be available in all your acceptance tests
  
  def logger
    Rails::logger
  end
  
end

Spec::Runner.configuration.include(HelperMethods)
