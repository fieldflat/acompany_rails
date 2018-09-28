class Tweet < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }

  has_many :favorites
  has_many :favs, through: :favorites, source: :user

  def fav(other_user)
      self.favorites.find_or_create_by(user_id: other_user.id)
  end

  def unfav(other_user)
    favorite = self.favorites.find_by(user_id: other_user.id)
    favorite.destroy if favorite
  end

  def faving?(other_user)
    self.favs.include?(other_user)
  end
  
end
