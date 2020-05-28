class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :artist_name, presence: true
    validates_presence_of :release_year, if: -> {released == true}
    validate :valid_year

    def valid_year
        today = Time.new
        if self.release_year != nil && self.release_year > today.year
            errors.add(:release_year, "release year can't be in the future")
        end
    end

end
