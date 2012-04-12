class UserImage
  include Mongoid::Document
  #include Mongoid::Paperclip

  embedded_in :user, :inverse_of => :user_images

  #has_mongoid_attached_file :image, :styles => { :medium => "260x180>", :thumb => "65x45>" }
end
