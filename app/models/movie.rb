class Movie < ActiveRecord::Base
    def self.with_ratings(ratings)#define a class-level method  takes an array of ratings
        self.where(:rating => ratings)
    end
    def self.all_ratings #the possible values of movie ratings are really the responsibility of the Movie model
        self.uniq.pluck(:rating).sort
    end
end
