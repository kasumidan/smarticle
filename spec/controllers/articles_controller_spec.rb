require 'rails_helper'

RSpec.describe SmarticleArticlesController, type: :controller do
  item = Item.create
  article_params = {smarticleable_id: item.id, smarticleable_type: item.class.name}
  article_params2 = {smarticleable_id: item.id, smarticleable_type: item.class.name}
  url_params = {owner_id: item.id, owner_class: item.class.name}
  url_params2 = {owner_id: item.id, owner_class: item.class.name}  

  context "GET /articles" do
    it "response with 200 status" do
      get :index, url_params
      expect(response).to have_http_status(200)
    end

    it "loads articles into @articles" do
      p1 = SmarticleArticle.create(article_params)
      p2 = SmarticleArticle.create(article_params)
      get :index, url_params

      expect(assigns(:articles)).to match_array([p1, p2])
    end

    it "can loads articles into @articles by label" do
      article_params2[:label] = 'post'
      p1 = SmarticleArticle.create(article_params2)
      p2 = SmarticleArticle.create(article_params)
      p3 = SmarticleArticle.create(article_params2)

      url_params2[:label] = 'post'

      get :index, url_params2

      expect(assigns(:articles)).to match_array([p1, p3])
    end
  end

  context "GET /articles/new" do
    it "response with 200 status" do
      get :new, url_params do
        expect(response).to have_http_status(200)
      end
    end

    it "knows it's owner: smarticleable" do
      get :new, url_params do
        expect(assigns(:smarticleable).id).to equal_to item.id
      end
    end
  end

  context "POST /articles" do
    title = 'A new article'
    url_params2[:smarticle_article] = {title: title, label: 'post'}

    it "create a new article" do
      post :create, url_params2
      
      expect(assigns(:article).title).to eq(title)
      expect(assigns(:article).label).to eq('post')
    end
  end


  context "SHOW /article" do
    it "response with 200 status" do
      p1 = SmarticleArticle.create(article_params)
      get :show, {id: p1.id}

      expect(response).to have_http_status(200)
    end

    it "find the correct article object" do
      article_params2[:title] = "The Title"
      p1 = SmarticleArticle.create(article_params2)
      get :show, {id: p1.id}

      expect(assigns(:article).title).to eq('The Title')
    end
  end

  context "UPDATE /article" do
    it "update article" do
      article_params2[:title] = "The Title"
      p1 = SmarticleArticle.create(article_params2)

      patch :update, {id: p1.id, smarticle_article: {title: "The New Title"}}

      expect(assigns(:article).title).to eq('The New Title')
    end
  end

  context "DESTROY /article" do
    it "destroy article" do
      article_params2[:title] = "The Title"      
      p1 = SmarticleArticle.create(article_params2)
      expect(SmarticleArticle.find_by(id: p1.id).title).to eq("The Title")

      delete :destroy, {id: p1.id}

      expect(SmarticleArticle.find_by(id: p1.id)).to eq nil
    end

    it "ajax: assign articles of the same owners" do
      article_params2[:title] = "The Title"
      item2 = Item.create
      params = {smarticleable_id: item.id, smarticleable_type: item.class.name}
      p1 = SmarticleArticle.create(params)
      p2 = SmarticleArticle.create(params)
      p3 = SmarticleArticle.create(article_params)
      p4 = SmarticleArticle.create(article_params)

      xhr :delete, :destroy, {id: p1.id}

      expect(assigns(:articles)).to match_array([p2, p3, p4])
    end

    it "ajax: assign articles of the same owners and labels" do
      article_params2[:title] = "The Title"
      item2 = Item.create
      params = {smarticleable_id: item.id, smarticleable_type: item.class.name, label: 'Label1'}
      p1 = SmarticleArticle.create(params)
      p2 = SmarticleArticle.create(params)
      p3 = SmarticleArticle.create(params)
      p4 = SmarticleArticle.create(article_params)

      xhr :delete, :destroy, {id: p1.id}

      expect(assigns(:articles)).not_to match_array([p2, p3, p4])
      expect(assigns(:articles)).to match_array([p2, p3])
    end
  end
end
