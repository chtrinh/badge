class Badges
  include MongoMapper::Document
  
  key :title, String
  key :filename, String
  key :description, String
  key :thumb, String
  key :tags, Array
   
end