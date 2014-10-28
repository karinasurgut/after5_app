ThinkingSphinx::Index.define :deal, :with => :active_record do
  indexes title, :sortable => true
  indexes content
  indexes venue.name, :as => :venue_name, :sortable => true
  indexes taggings.tag.name, as: :tags
  has venue_id, created_at, updated_at
end