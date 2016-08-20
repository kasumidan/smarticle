require 'rails_helper'

RSpec.describe SmarticleSectionsController, type: :controller do

  item = Item.create
  article_params = {smarticleable_id: item.id, smarticleable_type: item.class.name}
  article = SmarticleArticle.create article_params

  #context "GET /smartarticles" do
  #  
  #end

  context "GET /smartarticles/:smarticle_article_id/sections/new" do
    it "build new section according to section_type" do
      xhr :get, :new, {smarticle_article_id: article.id, section_type: 'image'}
      expect(assigns(:section).section_type).to eq('image')

      xhr :get, :new, {smarticle_article_id: article.id, section_type: 'text'}
      expect(assigns(:section).section_type).to eq('text')

      xhr :get, :new, {smarticle_article_id: article.id, section_type: 'video'}
      expect(assigns(:section).section_type).to eq('video')
    end

    it "assign a picture for image section" do
      xhr :get, :new, {smarticle_article_id: article.id, section_type: 'image'}

      expect(assigns(:picture).smarticle_section_id).to eq (assigns(:section).id)
    end

    it "assign a video for video section" do
      xhr :get, :new, {smarticle_article_id: article.id, section_type: 'video'}

      expect(assigns(:video).smarticle_section_id).to eq (assigns(:section).id)
    end
  end

  context "POST /smartarticles/:smarticle_article_id/sections" do
    it "create a new section" do
      title = 'SectionTitle'      
      xhr :post, :create, {smarticle_article_id: article.id, smarticle_section: {title: title}}
      
      expect(assigns(:section).title).to eq(title)
    end
  end

  context "DELETE /sections/:id" do
    it "delete specified section" do
      s1 = article.sections.create!
      s2 = article.sections.create!
      s3 = article.sections.create!

      xhr :delete, :destroy, {id: s1.id}
      
      expect(assigns(:article).sections).to match_array([s2, s3])
    end
  end

  context "EDIT /sections/:id" do
    it "render edit template" do
      s1 = article.sections.create!
      xhr :get, :edit, {id: s1.id}
      
      expect(response).to render_template("edit")
    end
  end

  context "PATCH /sections/:id" do
    it "update content of section" do
      s1 = article.sections.create(txt: 'TheText', title: 'TheTitle')
      xhr :patch, :update, {id: s1.id, smarticle_section:{title: 'TheNewTitle', txt: 'TheNewText'}}

      expect(assigns(:section).title).to eq('TheNewTitle')
      expect(assigns(:section).txt).to eq('TheNewText')
    end
  end

  context "POST /smartarticles/:article_id/sections/orders" do

    it "change section orders: order down" do
      arr = []
      6.times do
        arr << article.sections.create!
      end

      xhr :post, :sort, {smarticle_article_id: article.id, sid: arr[4].id, oldIndex: 4, newIndex: 1}

      order_arr = []
      SmarticleSection.all.each do |s|
        order_arr << s.display_order
      end

      expect(order_arr).to eq [0, 2, 3, 4, 1, 5]
    end

    it "change section orders: order up" do
      arr = []
      6.times do
        arr << article.sections.create!
      end
      
      xhr :post, :sort, {smarticle_article_id: article.id, sid: arr[1].id, oldIndex: 1, newIndex: 4}

      order_arr = []
      SmarticleSection.all.each do |s|
        order_arr << s.display_order
      end

      expect(order_arr).to eq [0, 4, 1, 2, 3, 5]
    end
  end
end
