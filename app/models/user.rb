class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  reverse_geocoded_by :cur_lat, :cur_lng do |obj,results|
    if geo = results.first
      obj.city = geo.city
      obj.state = geo.state
      obj.postal_code = geo.postal_code
    end
  end

after_validation :reverse_geocode

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
  def reverse_geocode_string
    session[:cur_geo] = geo.city + " " + geo.state + " " + geo.postal_code
  end       

  def cur_lat
    cookies[:lat_lng].split("|").split[0..0].join("")
  end

   def cur_lng
    cookies[:lat_lng].split("|").split[1..1].join("")
  end
end
