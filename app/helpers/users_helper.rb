module UsersHelper

  def userpic_for(user, type="small")
  	userpic = user.image.split("=")[0] << "=#{type}"
    image_tag(userpic, alt: user.name, class: "img-circle userpic")
  end
end
