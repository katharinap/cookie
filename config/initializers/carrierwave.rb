CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS', # required
    :aws_access_key_id => ENV["AWS_ACCESS_KEY"], # required
    :aws_secret_access_key => ENV["AWS_SECRET_KEY"] # required
  }
  config.fog_directory = ENV["AWS_BUCKET"] # required

  
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.development?
    config.storage = :file
  else
    config.storage = :fog
  end
  
  # To let CarrierWave work on heroku
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
