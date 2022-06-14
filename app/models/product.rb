# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  visible     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
class Product < ApplicationRecord

    extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, presence: { message: 'El nombre es requerido.'}
    validates :description, presence: { message: 'La descripción es requerida.'}

    validates :name, length: { maximum:200, minimum: 2}
    
    has_one_attached :image, :dependent => :destroy

    has_many :product_categories
    has_many :categories, through: :product_categories # join

    has_many :votes, as: :votable 

    has_many :comments, -> { order('id DESC')  }

    accepts_nested_attributes_for :categories

    scope :visible, -> { where(visible:true) }

    def category_default
        return self.categories.first.name if self.categories.any?
        'Sin categoría'
    end

    def self.populars
        joins("LEFT JOIN votes ON votes.votable_id = products.id AND votes.votable_type = 'Product'")
        .select("products.*, count(votes.id) as total")
        .group('products.id')
        .order('total DESC')
    end
end
