class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    process resize_to_fit: [250, 250]
  def default_url
   "E51711FC-56D8-431F-B2C9-04124182C753.jpeg"
  end
end
