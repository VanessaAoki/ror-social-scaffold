module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def render_posts
    out = ''
    if current_user.friend? params[:id]
      out << "<h3 class=\"ml-4 has-text-pink has-text-weight-semibold\">Latest posts:</h3>
              <ul class=\"posts\">
                #{render @posts}
              </ul>"
    end
    out.html_safe
  end

  def no_recent
    out = ''
    if @timeline_posts.empty?
      out += '<div class="no-post mt-2">'
      out += '<p class="has-text-centered mb-2"><b class="is-size-4">Looks like your feed is empty.</b>'
      out += '<br>Post something or add other'
      out += '<br>socinetics to get some content.</p>'
      out += image_tag '/assets/flame-no-connection.png', class: 'img', width: 300
      out += '</div>'

    end
    out.html_safe
  end

  def post_controls(post)
    out = '<div class="is-flex mb-3">'
    if user_signed_in? && current_user.id == post.user_id
      out += link_to (fa_icon 'edit'), edit_post_path(post), class: 'has-text-pink mr-4'
      out += link_to (fa_icon 'trash'), post, method: :delete,
                                              data: { confirm: 'Are you sure?' }, class: 'has-text-pink'
      out += '</div>'
    end
    out.html_safe
  end
end
