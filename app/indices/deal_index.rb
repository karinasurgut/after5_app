ThinkingSphinx::Index.define :deal, :with => :active_record do
  indexes title, :sortable => true
  indexes content
  indexes venue.name, :as => :venue_name, :sortable => true
  indexes venue.street, :as => :venue_street
  indexes venue.suburb, :as => :venue_suburb
  indexes venue.latitude, :as => :lat
  indexes venue.longitude, :as => :lng
  indexes taggings.tag.name, as: :tags
  has venue_id, created_at, updated_at
  has venue.latitude, :as => :latitude, :type => :float
  has venue.longitude, :as => :longitude, :type => :float
 end