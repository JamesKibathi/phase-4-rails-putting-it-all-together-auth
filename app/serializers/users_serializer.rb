class UsersSerializer < ActiveModel::Serializer
  attributes :username, :image_url, :bio
  has_many :recipes
end
