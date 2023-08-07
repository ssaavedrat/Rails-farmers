class Farmer < ApplicationRecord
    has_many :animals

    def to_s
        self.name
    end
    
end
