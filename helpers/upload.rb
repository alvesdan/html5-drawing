module UploadHelper
  
  def save_image(image_data)
    image_data = image_data.split(",")
    image = Base64.decode64(image_data[1])
    file_name = "#{DateTime.now.strftime('%Y%m%d%H%M%S%L')}"
    image_file = File.open("public/temp/#{file_name}.jpg", "w") do |f|
      f.write image
    end
    return file_name
  end
  
  def upload(file_name)
    bucket = ENV["AWS_BUCKET"]
    AWS::S3::DEFAULT_HOST.replace "s3-us-west-2.amazonaws.com"
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV["AWS_ACCESS_KEY_ID"],
      :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
    )
    AWS::S3::S3Object.store(
      "#{file_name}.jpg",
      open("public/temp/#{file_name}.jpg"),
      bucket,
      access: :public_read
    )
    return file_name
  end
  
  
  
end