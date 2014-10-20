function getGeoLocation() {
	if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(setGeoCookie, handle_error, {enableHighAccuracy: true, timeout: 15000, maximumAge: 75000});
  }
  else {
  	alert("Geolocation is not supported by this browser");
  }
}

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}

function handle_error(err) {
  var errors = { 
     1: 'Permission denied',
     2: 'Position unavailable',
     3: 'Request timeout'
   };
   alert("Error: " + errors[error.code]);
}