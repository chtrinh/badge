class Badges
  include MongoMapper::Document
  
  key :title, String
  key :description, String
  key :tags, Array
  key :image_uid, String
    
  image_accessor :image
end