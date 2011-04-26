class Award
  include MongoMapper::Document
  
  key :title, String
  key :description, String
  key :tags, Array
  key :image_uid, String
    
  image_accessor :image
  
  def default_thumb(dimensions='150x150#')
    self.image.thumb(dimensions).url
  end
  
  def tag_input=(input)
    self.tags = input.split(/[\s,]+/)
  end
  
  def tag_input
    self.tags.join(' ')
  end
end