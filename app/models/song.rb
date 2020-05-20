require 'byebug'
class Song < ApplicationRecord
  validates :artist_name, presence: true
  validates :title, presence: true 
  validates :released, inclusion: { in: [ true, false ] }
  # validate :title_cannot_be_repeated
  validates_uniqueness_of :title, scope: [:release_year, :artist_name]
 
  with_options if: :released? do |song|
    song.validates :release_year, presence: :true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year 
    }
  end

  def released?
    released 
  end
 
end

