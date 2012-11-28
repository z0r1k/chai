
// Geolocation object that gets Users current position by
// longitude & latitude + some additional functions to help with
// providing data and populating the main page and google map
var Geolocation = {
  init: function() {
    $('.find-shops').on('click', this.getGeoLocation);
    $('#map-something').on('ajax:success', this.shopLists);
    this.currentPosition();
  },

// function that creates the map and displays it on our main page
  createMap: function(lngLat) {
    var mapOptions = {
      zoom: 13,
      center: lngLat,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
    return map;
  },

// function that returns and displays a list of our Yelp search query for coffeeshops
// also populates the google map with pins accordingly
  shopLists: function(event, data) {
    $('#map-something').append("<li> " + data.region.join(" ") + " </li>")
    for (var i = 0; i < data.businesses.length - 1; i++) {
      $('#map-something').append("<li> " + data.businesses[i].join(" ") + " </li>");
      var myLatlng = new google.maps.LatLng(data.businesses[i][6],data.businesses[i][7]);
      var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: data.businesses[i][0], //name
    });
    }
  },

// function to get the users current position based on geolocation
// also adds a pin to the google map with a hover text that reads 'You're here
  currentPosition: function()  {
     navigator.geolocation.getCurrentPosition(function(position){
        var myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        var marker = new google.maps.Marker({
          position: myLatlng,
          map: Geolocation.createMap(myLatlng),
          title: "You're here", //name
        });
     });

  },

// function that sends an Ajaxs request to our rails sever and waits for a reply
// on successful reply triggers a 'success' which causes the displaying of our query items
  getGeoLocation: function() {
    navigator.geolocation.getCurrentPosition(function(position){
      $.ajax({
        type: 'post',
        url: '/shops',
        dataType: 'json',
        data: {longitude: position.coords.longitude, latitude: position.coords.latitude},
        success: function(data, status, xhr) {
          $('#map-something').trigger('ajax:success', [data, status, xhr]);
        },
        error: function(xhr, status, error) {
          $('#map-something').trigger('ajax:error', [xhr, status, error]);
        },
        complete: function(xhr, status) {
          $('#map-something').trigger('ajax:complete', [xhr, status]);
        }
      });
    });
  }
};

// document ready wrapper for our Geolocation object
$(document).ready(function(){
  Geolocation.init();

});




