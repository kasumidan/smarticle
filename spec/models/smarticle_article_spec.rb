require 'rails_helper'

RSpec.describe SmarticleArticle, type: :model do
  it 'has many sections' do
    a = SmarticleArticle.create!
    a.sections.create!
    a.sections.create!

    expect(a.sections.count).to eq 2
  end

  it 'has many pictures through sections' do
    a = SmarticleArticle.create!
    s = a.sections.create!
    p1 = s.pictures.create!
    p2 = s.pictures.create!

    expect(a.pictures).to eq [p1, p2]
  end

  it 'has many videos through sections' do
    a = SmarticleArticle.create!
    s = a.sections.create!
    v1 = SmarticleVideo.create(section: s)
    v2 = SmarticleVideo.create(section: s)
    expect(a.videos).to eq [v1, v2]
  end
end
