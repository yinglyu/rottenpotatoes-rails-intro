class Movie < ActiveRecord::Base
    def self.with_ratings(ratings)#define a class-level method  takes an array of ratings
        self.where(:rating => ratings)
    end
end
