module UsersHelper
  def gravatar_for(user,size)
    #Generate hex token from gravatar
    gravatar_id = Digest::MD5::hexdigest(user.email)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "rounded-circle #{size}")
  end
end
