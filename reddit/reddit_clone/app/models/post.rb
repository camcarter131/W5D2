class Post < ApplicationRecord
  validates :title, :author_id, presence: true 

  # has many post_subs, DD-destroys in the post_subs if this is deleted
  # inverse of says create same association with sub
  has_many :post_subs, 
  dependent: :destroy, 
  inverse_of: :post,
  foreign_key: :post_id,
  primary_key: :id,
  class_name: :PostSub


  has_many :subs,
  through: :post_subs,
  source: :sub

  belongs_to :author,
  class_name: :User
end
