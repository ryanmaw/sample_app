class Micropost < ActiveRecord::Base
	belongs_to :user

	 validates :user_id, presence: true
	 validates :content, length: { maximum: 140, minimum: 1 }

	 default_scope { order( 'microposts.created_at DESC') }
end
