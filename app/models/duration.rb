class Duration < ActiveRecord::Base
	belongs_to :deal
	default_scope -> { order('created_at ASC') }
end
