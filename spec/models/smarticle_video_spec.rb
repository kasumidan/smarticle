require 'rails_helper'

RSpec.describe SmarticleVideo, type: :model do
  it 'belongs to section' do
    section = SmarticleSection.create!
    v = SmarticleVideo.create(smarticle_section_id: section.id)
    expect(v.section.id).to equal_to section.id
  end
end
