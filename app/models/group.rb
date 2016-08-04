class Group < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :title, format: { with: /\A[a-zA-Z]+\z/, message: "Only allows letters"}

  has_many :posts
end
