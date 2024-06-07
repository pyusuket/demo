class Post < ApplicationRecord
  has_many   :comments, dependent: :destroy
  # belongs_to :user, dependent: :destroy
  has_one_attached :image
  # validates  :title, presence: true, length: { maximum: 20  }
  # validates  :body,  presence: true, length: { maximum: 400 }

  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode

end
