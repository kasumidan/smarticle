class SmarticlePicturesController < SmarticleController
  before_action :check_auth

  before_action :set_article, only: [:new, :create]

  def create
    pic_array = []
    params[:images].each do |key, img|
      @picture=SmarticlePicture.new(image: img)
      if @picture.save
        pic_array << @picture
      end
    end

    # attach uploaded pictures to a new section
    unless pic_array.blank?
      @section = @article.sections.new(section_type: 'image')      
      pic_array.each do |picture|
        picture.section = @section
        picture.save
      end
      render json: { message: "success",  status: 200}
    else
      render json: { message: "failed",  status: 403}
    end
  end

  def destroy
    @picture = SmarticlePicture.find(params[:id])
    @section = @picture.section
    @article = @section.article
    @picture.destroy

    # destroy section itself if no picture left
    @section.destroy if @section.pictures.blank?

    render 'smarticle_sections/index'
  end

  private
    def set_article
      @article = SmarticleArticle.find(params[:smarticle_article_id])
    end

    def image_params
      params.require(:picture).permit(:image)
    end
end
