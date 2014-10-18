module UsersHelper

	def userpic_for(user, options = { size: 40 })
    size = options[:size]
    userpic = user.image
    image_tag(userpic, alt: user.name, class: "img-circle userpic")
  end
end
