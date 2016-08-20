class SmarticleSectionsController < SmarticleController
  before_action :check_auth, except: [:index, :show]

  before_action :set_article, only: [:index, :new, :create, :sort]
  before_action :set_section, only: [:show, :edit, :update, :destroy, :cancel_edit]

  #skip_before_filter :verify_authenticity_token, :only => :create

  def index
    @sections = @article.sections.order(display_order).all
    @section = @article.sections.new
  end

  def new
    @picture = SmarticlePicture.new
    @section = @article.sections.new(section_type: params[:section_type], width: 100)
    @picture = SmarticlePicture.new if @section.section_type == 'image'
    @video = SmarticleVideo.new if @section.section_type == 'video'
  end

  def edit
    @video = @section.video
  end

  def create
    @section = @article.sections.new(section_params)
    if @section.save
      render :index
    else
      render :new, status: 403
    end
  end

  def update
    @section.update(section_params)
    @article = @section.article  #important!
    render :index
  end

  def destroy
    @article = @section.article
    @section.destroy
    render :index
  end

  def sort
    Smarticle::SmarticleHelper.change_order(@article.sections, 'display_order', 
      SmarticleSection.find(params[:sid]).display_order, 
      params[:oldIndex].to_i, 
      params[:newIndex].to_i)
    
    render :index
  end

  def cancel_edit
    render :cancel_edit
  end

  private
  
    def section_params
      params.require(:smarticle_section).permit(:title, :txt, :section_type, :width)
    end

    def set_article
      @article = SmarticleArticle.find(params[:smarticle_article_id])
    end

    def set_section
      @section = SmarticleSection.find(params[:id])
    end
end
