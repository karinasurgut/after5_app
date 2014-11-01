# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
badge_id = 0
[{
  id: (badge_id = badge_id+1),#1
  name: 'happy-hour-newbie',
  description: 'Congrats on your first check-in!',
  custom_fields: { image: 'newbie.png'}
}, {
  id: (badge_id = badge_id+1),
  name: 'adventurer',
  description: "You've checked into 10 different venues!",
  custom_fields: { image: 'adventurer.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'explorer',
  description: "You've checked into 25 different venues!",
  custom_fields: { image: 'explorer.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'bender',
  description: "That's 4+ nights in a row for you!",
  custom_fields: { image: 'bender.png' }
}, {
  id: (badge_id = badge_id+1),#5
  name: 'pub-crawl',
  description: "That's 4+ stops in a row for you!",
  custom_fields: { image: 'pubcrawl.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'the-regular',
  description: "You've been at the sme place 3 times in one week!",
  custom_fields: { image: 'regular.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'super-user',
  description: "That's 30 check-ins in a month for you!",
  custom_fields: { image: 'superuser.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'party',
  description: "50+ people are also checked-in here - it's an After5 party!",
  custom_fields: { image: 'party.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'night-owl',
  description: "Late to bed and early(ish) to rise. Good luck making it through the day. Tip: Blue gatorade will be your bestest friend.",
  custom_fields: { image: 'nightowl.png' }
}, {
  id: (badge_id = badge_id+1),#10
  name: 'newtown-hipster',
  description: "That's 3 check-ins in Newtown. You'd fit right in with a pair of skinny jeans.",
  custom_fields: { image: 'hipster.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'pool-master',
  description: "Nice job on the table!",
  custom_fields: { image: 'poolmaster.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'after5-summer',
  description: "Your summer is officially underway now that you've found an After5 Summer hot spot! Time so soak up the season with sun, fun, and some great specials!",
  custom_fields: { image: 'summer.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'cupcake-connoisseur',
  description: "A true cupcake connoisseur, you know the goods when you see (and taste) them!",
  custom_fields: { image: 'cupcake.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'beer-garden',
  description: "It can get pretty hot standing in the sun, but you're obviously the smart one in the crowd because you've tracked down the beer garden!",
  custom_fields: { image: 'beergarden.png' }
}, {
  id: (badge_id = badge_id+1),#15
  name: 'local-flavour',
  description: "Everyone loves fresh beer, but obviously not as much as you do. You went straight to the source! Supporting local breweries is what helps the craft beer scene grow.",
  custom_fields: { image: 'local.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'taste-the-music',
  description: "Beer and music share many similarities; different styles, different collaborations It's no wonder they go well together!",
  custom_fields: { image: 'tastethemusic.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'sharer',
  description: "Sharing is Caring. Obviously you know this since you've been sharing your check-ins with all of your friends!",
  custom_fields: { image: 'sharer.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'your-wish-come-true',
  description: "If you only had one wish, we bet it would be to enjoy at least 10 deals from your wish list in a 30 day period.",
  custom_fields: { image: 'yourwish.png' }
}, {
  id: (badge_id = badge_id+1),
  name: 'playing-the-field',
  description: "Does the word picking favorites mean anything to you? Obviously not. That's 10 different deals in a row.",
  custom_fields: { image: 'playingthefield.png' }
}, {
  id: (badge_id = badge_id+1),#20
  name: 'suburb-traveller',
  description: "You're exploring this great city the best way possible, one great deal at a time! That's one deal in at least 5 suburbs.",
  custom_fields: { image: 'suburbtraveller.png' }
}].each do |attrs|
  Merit::Badge.create! attrs
end
