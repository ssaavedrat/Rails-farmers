class Farmer < ApplicationRecord
    has_many :animals, dependent: :destroy
    belongs_to :farm

    def to_s
        self.name
    end

end
