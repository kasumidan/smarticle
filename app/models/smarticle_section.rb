class SmarticleSection < ActiveRecord::Base
  belongs_to :article, class_name: 'SmarticleArticle', foreign_key: :smarticle_article_id

  has_many :pictures, class_name: 'SmarticlePicture', dependent: :destroy
  has_one :video, class_name: 'SmarticleVideo', dependent: :destroy

  after_create do
    self.update(display_order: id)
  end
end
