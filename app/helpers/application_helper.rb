module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def user_navbar
    out = ''
    if user_signed_in?
      out += '<p>'
      out += link_to current_user.name, edit_user_registration_path, class: 'button ml-2 is-navbar'
      out += '</p>'
      out += '<p>'
      out += link_to 'Logout', destroy_user_session_path, method: :delete, class: 'button ml-2 is-navbar'
    else
      out += '</p>'
      out += '<p>'
      out += link_to 'Log In', new_user_session_path, class: 'button is-navbar'
      out += '</p>'
      out += '<p>'
      out += link_to 'Sign Up', new_user_registration_path, class: 'button is-navbar'
      out += '</p>'
    end
    out.html_safe
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Unlike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def render_sign_in
    out = ''
    if current_user
      out << link_to(current_user.name, user_path(id: current_user.id))
      out << link_to('Sign out', destroy_user_session_path, method: :delete)
    else
      out << link_to('Sign in', user_session_path)
    end
    out.html_safe
  end
end
