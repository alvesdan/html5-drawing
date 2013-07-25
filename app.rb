require "base64"
require_relative "helpers/upload"

class MyApp < Sinatra::Base
  
  helpers UploadHelper
  
  get "/" do  
    haml :index
  end
  
  post "/save" do
    file_name = save_image(params[:image_data])
    upload(file_name)
  end
  
  get "/drawings" do
    AWS::S3::DEFAULT_HOST.replace "s3-us-west-2.amazonaws.com"
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV["AWS_ACCESS_KEY_ID"],
      :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
    )
    @drawings = AWS::S3::Bucket.find(ENV["AWS_BUCKET"]).objects
    haml :drawings
  end
  
end