require "base64"

class MyApp < Sinatra::Base
  
  get "/" do  
    haml :index
  end
  
  post "/save" do
    image_data = params[:image_data].split(",")
    image = Base64.decode64(image_data[1])
    image_file = File.open("public/temp/#{DateTime.now.strftime('%Y%m%d%H%M%S%L')}.jpg", "w") do |f|
      f.write image
    end
  end
  
end