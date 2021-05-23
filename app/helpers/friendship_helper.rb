# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Style/OptionalBooleanParameter

module FriendshipHelper
  def follow_btn(id = nil, is_me = false)
    out = ''
    friend = current_user.friend?(id || params[:id])
    if is_me || @is_me
      out << if current_user.request?(id || params[:id])
               accept_decline(id || params[:id])
             elsif friend == false
               link_to('Add Friend', friendships_url(friend_id: (id || params[:id])), method: :post, class: 'button is-pink mt-3')
             elsif friend.nil?
               'Pending'
             else
              link_to "Destroy", friendship_path(current_user.friendships.find_by_friend_id(friend)), :method => :delete, class: 'button is-pink'
             end
    end
    out.html_safe
  end

  def list_friends
    out = ''
    @friends.each do |f|
      puts f
      out << "<li>#{f.name} #{current_user.friend?(f.id).nil? ? ', pending' : ''}<li>"
    end
    out.html_safe
  end

  def accept_decline(user_id)
    out = ''
    out << "<div>
              #{link_to('Accept', friendship_url(id: user_id), method: :patch, class: 'button is-pink')}
              #{link_to('Decline', friendship_url(id: user_id), method: :delete, class: 'button is-pink')}
          </div>"
    out.html_safe
  end

  def list_requests
    out = ''
    @requests.each do |f|
      out << "<li class=\"for-btn\">
                <strong>#{f.name}</strong>
                #{accept_decline(f.id)}
            </li>"
    end
    out.html_safe
  end

  def render_requests
    out = ''
    unless @requests.empty?
      out << "<h1>Friend requests</h1>
                    <ul>
                        #{list_requests}
                    </ul>"
    end
    out.html_safe
  end

  def render_all_users
    out = ''
    out << '<ul class="users-list is-flex is-justify-content-space-between">'
    @users.each do |user|
      next unless user.id != current_user.id

      out << "<li class=\"single-user\">
                <strong>#{link_to user.name, user_path(id: user.id), class:'has-text-pink is-size-5'}</strong>
                <div>#{follow_btn(user.id, true)}</div>
              </li>"
    end
    out << '</ul>'
    out.html_safe
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Style/OptionalBooleanParameter
