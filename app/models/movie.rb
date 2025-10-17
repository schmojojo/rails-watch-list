class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  # Prevent destroying a movie if it has bookmarks
  before_destroy :check_for_bookmarks

  private

  def check_for_bookmarks
    if bookmarks.exists?
      # This ensures destroy returns false
      errors.add(:base, "Cannot delete movie with bookmarks")
      throw(:abort)   # cancels the destroy
    end
  end
end
