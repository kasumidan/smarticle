module Smarticle::ApplicationHelper
  def articles_of owner, opt=nil
    return nil if owner.blank?

    articles = SmarticleArticle.where(smarticleable_id: owner.id, smarticleable_type: owner.class.name)
    if opt[:label].present?
      articles = articles.where(label: opt[:label]).order(id: :desc)
    end

    if opt[:limit].present?
      articles = articles.limit(opt[:limit])
    end
    articles
  end

  def article_by_label owner, label
    return nil if (owner.blank? or label.blank?)

    SmarticleArticle.find_by(smarticleable_id: owner.id, smarticleable_type: owner.class.name, label: label)
  end

  def articles_by_label owner, label
    return nil if (owner.blank? or label.blank?)

    SmarticleArticle.where(smarticleable_id: owner.id, smarticleable_type: owner.class.name, label: label)
  end

  def articles_link owner, opt=nil
    smarticle_articles_path(
      owner_id: owner.id, owner_class: owner.class.name, 
      label: opt[:label], 
      title: opt[:title],
      return_to: opt[:return_to]
    )
  end
  
  def new_article_link owner, opt=nil
    if opt.blank?
      new_smarticle_article_path(owner_id: owner.id, owner_class: owner.class.name)
    else 
      new_smarticle_article_path(
        owner_id: owner.id, owner_class: owner.class.name, 
        skip_title: opt[:skip_title],
        label: opt[:label], 
        return_to: opt[:return_to],
        type: opt[:type]
      )
    end
  end

  def edit_article_link article, opt=nil
    edit_smarticle_article_path(id: article, return_to: opt[:return_to])
  end

  def article_link article, opt=nil
    smarticle_article_path(id: article, return_to: opt[:return_to])
  end

  def cal_section_col_num section
    col_arr = [12, 8, 6, 4]
    width_arr = [100, 66, 50, 33]
    width = section.width.blank? ? 100 : section.width
    return col_arr[width_arr.index(width)]
  end

  def smarticle_check_auth
    if Smarticle.owner_class.present?
      auth_method_name = "authenticate_" +Smarticle.owner_class.to_s.downcase + "!"
      send(auth_method_name)
    end
  end

  def render_article owner, label, opt=nil
    article = article_by_label(owner, label)
    render 'share/article_with_edit', owner: owner, article: article, label: label, opt: opt
  end

  def render_the_article article, opt=nil
    return nil if article.nil?
    render 'share/article_with_edit', owner: article.smarticleable, article: article, opt: opt
  end
end
