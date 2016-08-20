class SmarticleArticle < ActiveRecord::Base
  belongs_to :smarticleable, polymorphic: true

  has_many :sections, class_name: 'SmarticleSection', dependent: :destroy
  has_many :pictures, through: :sections
  has_many :videos, through: :sections

  def txt
    str = ''
    sections.where(section_type: 'text').each do |sec|
      str += '[' + sec.title + '] ' if sec.title.present?
      str += sec.txt if sec.txt.present?
    end

    str
  end

  def cover_image
    s = sections.where(section_type: 'image').first
    return s.present? ? s.pictures.first : nil
  end
end
