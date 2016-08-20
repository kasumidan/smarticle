class SmarticleArticlesController < SmarticleController

  before_action :check_auth, except: [:index, :show]
  before_action :set_smarticleable, only: [:index, :new]
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  before_action :remove_empty_section, only: [:edit, :show]

  def index
    @articles = SmarticleArticle.where(
      smarticleable_type: @type,
      smarticleable_id: @smarticleable.id)
    if params[:label].present?
      @articles = @articles.where(label: params[:label])
    end

    @title = params[:title]
  end

  def new
    unless params[:skip_title] == 'yes'
      @article = SmarticleArticle.new(smarticleable: @smarticleable, label: params[:label], article_type: params[:type])
      @return_to = params[:return_to]
    else
      @article = SmarticleArticle.create(smarticleable: @smarticleable, label: params[:label], article_type: params[:type])
      redirect_to edit_smarticle_article_path(id: @article, return_to: params[:return_to])
    end
  end

  def edit
    @return_to = params[:return_to]
  end

  def create
    @article = SmarticleArticle.new(article_params)

    if @article.save
      redirect_to edit_smarticle_article_path(id: @article, return_to: params[:return_to])
    else
      render :new, status: 403
    end
  end

  def update
    if @article.update(article_params)
      render :edit
    else
      render :edit, status: 403
    end
  end

  def show
  end

  def destroy
    @smarticleable = @article.smarticleable
    @type = @article.smarticleable_type
    @label = @article.label
    @article.destroy

    respond_to do |format|
      format.js {
        @articles = SmarticleArticle.where(smarticleable_type: @type, smarticleable_id: @smarticleable.id, label: @label)
        render :index
      }
      format.html {
        redirect_to params[:return_to] || smarticle_articles_path(owner_id: @smarticleable.id, owner_class: @smarticleable.class.name, label: @label)
      }
    end
  end

  private
    def check_auth
      send(Smarticle.check_auth_method)
    end

    def article_params
      params.require(:smarticle_article).permit(:title, :smarticleable_type, :smarticleable_id, 
        :label, :article_type,
        sections_attributes: [:id, :title, :txt, :_destroy])
    end

    def set_articles
      
    end

    def set_smarticleable
      @smarticleable = params[:owner_class].constantize.find(params[:owner_id])
      @type = params[:owner_class]
    end

    def set_article
      @article = SmarticleArticle.find(params[:id])
    end

    def remove_empty_section
      #画像がないimage section, テキストがないtext sectionなどを削除
      @article.sections.each do |s|
        case s.section_type
        when 'image'
          s.destroy and s=nil if (s.title.blank? && s.pictures.blank?)
        when 'text'
          s.destroy and s=nil if (s.title.blank? && s.txt.blank?)
        end
      end
    end
end
