class Book < ApplicationRecord
	belongs_to :user
    validates :body,presence: true
    validates :title,presence: true ,length:{ maximum: 200}

end
