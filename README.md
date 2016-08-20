# Smarticle (Smart Article)

## How to Use From App

First, include the engine inside the Gemfile.

    gem 'smarticle', path: path_to_smarticle_engine

## Use the Assets of The Engine
Add following line to app/config/initializers/assets.rb

    Rails.application.config.assets.precompile += %w( smarticle/* )

Then add

    //= require smarticle

to app/assets/javascript/application.js

and

    @import "smarticle/style";

to app/assets/stylesheets/application.scss

## Configuration of Smarticle Engine

Smarticle engine can work together with devise. For example, if article's create, edit and delete actions are only available for user signed_in, add following settings to smarticle configration file app/initializers/smarticle.rb

    Smarticle.owner_class = "User"
    Smarticle.check_auth_method = "authenticate_user!"

## Examples

Suppose you are going to add a summary to an user. 

    # model/user.rb

    has_many smarticles, as: :smarticleable, dependent: :destroy, class_name: 'SmarticleArticle'

    private
    def summary
      smarticles.where(label: 'summary').first
    end

    # view/users/new.html.slim
    = link_to 'Add Summary', new_article_link(@user, {label: 'summary'})

Link to the summary:

    = link_to 'View Summary', article_link(@user.summary)

If you want to add a return url to the end of the article view, 

    = link_to 'View Summary', article_link( @user.summary, {return_to: path_of_return_to })

Remember to replace path\_of\_return_to with the exact path!


To show the summary,

    = render_the_article @summary

    #or

    = render_article @user, 'summary'

    # with options
    = render_article @user, 'summary', {name: 'User Summary', return_to: user_path(id: @user), editable: true}

## Helpers

###New smarticle link of @user:

    =new_article_link @user
    =new_article_link @owner, {label: 'summary'}

###Edit link:
    
    =edit_article_link @article

###Link to the article:

    =article_link @article

    =article_link article, {return_to: path_to_return}

###Render article's view:
    =render_the_article article_by_label(@user, 'summary')

    =render_article @user, 'summary'

    =render_article @user, 'summary', options

###Available options are as follows:
    
* name: name of the article page
* return_to: path for the go back link on article's page
* editable: if _true_, edit and remove link will be attached
* add\_new: if _true_, an add_new link will be attached
* new_opt: options when create a new article of the same label
  * type: type of the article to be newly created
    * if _simple\_text_, no image or video will be able to added, and width of paragraph cannot be changed
    * if _text_, no image or video will be able to added
    * if _nil_, image, video and width change are available
  * skip\_title: if _true_, an article without title will be created
# smarticle
