class SmarticlePicture < ActiveRecord::Base
  belongs_to :section, class_name: 'SmarticleSection', foreign_key: :smarticle_section_id

  has_attached_file :image,
    styles: lambda { |image| image.instance.styles },
    path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:filename',
    default_url: '/default-images/default.png'

  def dynamic_style_format_symbol
    URI.escape(@dynamic_style_format).to_sym
  end

  def styles
    unless @dynamic_style_format.blank? 
      { dynamic_style_format_symbol => {geometry: @dynamic_style_format} }
    else
      {
        medium: "640x640>",
        thumb: "160x160>"
      }
    end
  end

  def dynamic_file_url(format)
    @dynamic_style_format = format
    image.reprocess!(dynamic_style_format_symbol) unless image.exists?(dynamic_style_format_symbol)
    image.url(dynamic_style_format_symbol)
  end

  validates_attachment_content_type :image, content_type: ['application/pdf', /\Aimage\/.*\Z/]
end
