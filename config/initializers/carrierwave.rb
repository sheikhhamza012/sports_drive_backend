CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['aws_access_key'],                        # required unless using use_iam_profile
      aws_secret_access_key: ENV['aws_secret_key'],                        # required unless using use_iam_profile
      region:                ENV['aws_region'],                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['aws_bucket']                                      # required
end