class SmarticleVideosController < SmarticleController
  before_action :check_auth
  before_action :set_article, only: [:new, :create, :destroy]

  def create
    set_video_id
    @video = SmarticleVideo.new(video_id: @video_id, video_type: 'youtube')
    @section = @article.sections.new(section_type: 'video')
    if @video_id.present? && @video.save
      @video.section = @section
      @video.save

      render 'smarticle_sections/index'
    else
      @error = t('smarticle.error.video_link_incorrect')
      render 'smarticle_sections/new'
    end
  end

  def destroy
    @video = SmarticleVideo.find(params[:id])
    @section = @video.section
    @video.destroy

    # destroy section itself
    @section.destroy

    render 'smarticle_sections/index'
  end

  private
  def set_article
    @article = SmarticleArticle.find(params[:smarticle_article_id])
  end

  def set_video_id
    @video_id = nil
    url = params[:video_url]
    if url.include?'youtu'
      matches = url.match(/^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S*)$/)
      @video_id = matches.nil? ? nil : matches[1]
    end
  end
end
