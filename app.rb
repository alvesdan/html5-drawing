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
    connect()
    @drawings = AWS::S3::Bucket.find(ENV["AWS_BUCKET"]).objects
    haml :drawings
  end
  
end