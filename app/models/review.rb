# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  chef_id    :integer
#  recipe_id  :integer
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Review < ActiveRecord::Base 
  belongs_to :recipe
  belongs_to :chef 
  
  validates_uniqueness_of :chef, scope: :recipe
end
