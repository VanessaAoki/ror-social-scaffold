module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def render_posts
    out = ''
    if current_user.friend? params[:id]
      out << "<h3>Recent posts:</h3>
              <ul class=\"posts\">
                #{render @posts}
              </ul>"
    end
    out.html_safe
  end
end
