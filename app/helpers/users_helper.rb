module UsersHelper

  def userpic_for(user, type="small")
  	#options: small square normal large
  	userpic = user.image.split("=")[0] << "=#{type}"
    link_to image_tag(userpic, alt: user.name, class: "img-circle userpic"), user_path(user)
  end

  def first_name_for(user)
    first_name = user.name.split[0..0].join("")
  end

  def cur_location
    cur_location = cookies[:cur_geo]

  end 
end
