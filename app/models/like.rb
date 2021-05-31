# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :bigint           not null
#  song_id    :string           not null
#
# Indexes
#
#  index_likes_on_fan_id  (fan_id)
#
# Foreign Keys
#
#  fk_rails_...  (fan_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :fan, class_name: "User"
  
  validates :fan_id, uniqueness: { scope: :song_id, message: "has already liked this song" }
end
