# == Schema Information
#
# Table name: styles
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Style < ActiveRecord::Base 
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  has_many :recipe_styles
  has_many :recipes, through: :recipe_styles
end
