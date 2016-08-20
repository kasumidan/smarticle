require 'rails_helper'

RSpec.describe SmarticleSection, type: :model do
  it 'belongs to article' do
    article = SmarticleArticle.create!
    s = article.sections.create!
    p s.article
  end

end
