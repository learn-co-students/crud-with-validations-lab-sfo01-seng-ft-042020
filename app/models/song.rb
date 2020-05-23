class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validates :released, inclusion: {in: [true, false]}
    validates :release_year, numericality: {less_than_or_equal_to: Time.now.year}, if: :released
    validates_uniqueness_of :title, scope: [:release_year, :artist_name], message: "is already a song by this artist for this year."


    def no_dupe_song_names_same_year
        unless Song.all.where(artist_name: artist_name, title: title, release_year: release_year).empty?
            errors.add(title, "is already a song by #{artist_name} for #{release_year}.")
        end
    end
end

