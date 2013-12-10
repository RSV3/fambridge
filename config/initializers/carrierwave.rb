CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',                    # required
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],    # required
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],    # required
      :region                 => 'us-east-1',              # optional, defaults to 'us-east-1'
      #:host                   => '',                 # optional, defaults to nil
      :endpoint               => ENV['AWS_ENDPOINT']  # optional, defaults to nil
    }
    config.fog_directory  = ENV['AWS_BUCKET']                     # required
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  else
    config.storage = :file
    config.enable_processing = false
  end
end

