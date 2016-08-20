require 'rails_helper'

RSpec.describe SmarticlePicture, type: :model do
  it 'belongs to section' do
    section = SmarticleSection.create!
    pic = section.pictures.create!
    p pic.section
  end
end
