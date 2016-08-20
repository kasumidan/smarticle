class SmarticleVideo < ActiveRecord::Base
  belongs_to :section, class_name: 'SmarticleSection', foreign_key: :smarticle_section_id
end
