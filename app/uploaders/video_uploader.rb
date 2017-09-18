# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  if Rails.env == "development"
    include CarrierWave::MiniMagick
  else
    include Cloudinary::CarrierWave
  end

  include CarrierWave::FFMPEG

  # Choose what kind of storage to use for this uploader:
  storage :file if Rails.env == "development"
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.channel.channel_id.titleize}/#{model.created_at.strftime('%Y_%m_%d')}"
  end

  version :mp4 do
    process encode_video: [:mp4]
  end

  # version :webm do
  #   process encode_video: [:webm]
  # end

  def extension_white_list
    %w(mp4)
  end

end
