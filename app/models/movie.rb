class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true

  # Optional: prevent deleting a movie if it has bookmarks
  before_destroy :check_for_bookmarks

  private

  def check_for_bookmarks
    if bookmarks.exists?
      errors.add(:base, "Cannot delete movie with bookmarks")
      throw(:abort)
    end
  end
end
