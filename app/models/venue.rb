class Venue < ActiveRecord::Base
	has_many :deals, dependent: :destroy
	has_many :hours, dependent: :destroy, foreign_key: "venue_id"
	accepts_nested_attributes_for :hours, limit: 7
	acts_as_taggable
	before_save do
	  email.downcase!
	  street.split.map(&:downcase).map(&:capitalize).join(' ')
	  suburb.split.map(&:downcase).map(&:capitalize).join(' ')
	  region.split.map(&:downcase).map(&:capitalize).join(' ')
	end
	geocoded_by :venue_address
	after_validation :geocode, if: :venue_address_changed?

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

  private

    def venue_address
      "#{street} #{suburb} #{postcode} #{state} #{country}"
    end

    def venue_address_changed?
      true if (self.street_changed? || self.suburb_changed? || self.postcode_changed? || self.state_changed? || self.country_changed?)

    end
end
