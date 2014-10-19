class Venue < ActiveRecord::Base
	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50, minimum: 2}, 
			  uniqueness: { case_sensitive: false }
	validates :street, presence: true, length: { maximum: 50}
	validates :suburb, presence: true, length: { maximum: 20}
	validates :phone, presence: true, length: { maximum: 12}
	validates :postcode, presence: true, length: { maximum: 4, minimum: 4}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX }
    VALID_WEBSITE_REGEX = /\A^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\z/i
    validates :website, format: { with: VALID_WEBSITE_REGEX }
end
