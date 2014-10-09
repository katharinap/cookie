CarrierWave.configure do |config|
  config.enable_processing = false
end

RSpec.configure do |config|
  include CarrierWave::Test::Matchers
end
