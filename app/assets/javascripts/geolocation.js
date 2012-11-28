var Geolocation = {
  init: function() {
    $('.find-shops').on('click', this.getGeoLocation);
    $('#map-something').on('ajax:success', this.shopLists);
    this.currentPosition();
  },

  createMap: function(lngLat) {
    var mapOptions = {
      zoom: 13,
      center: lngLat,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
    return map;
  },

  shopLists: function(event, data) {
    $('#map-something').append("<li> " + data.region.join(" ") + " </li>")
    for (var i = 0; i < data.businesses.length - 1; i++) {
      $('#map-something').append("<li> " + data.businesses[i].join(" ") + " </li>");
      var myLatlng = new google.maps.LatLng(data.businesses[i][4],data.businesses[i][5]);
      var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: data.businesses[i][0], //name
    });
    }
  },

  currentPosition: function()  {
     navigator.geolocation.getCurrentPosition(function(position){
        var myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        var marker = new google.maps.Marker({
          position: myLatlng,
          map: Geolocation.createMap(myLatlng),
          title: "You're Here", //name
        });
     });

  },

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

$(document).ready(function(){
  Geolocation.init();

});


  // $('.add-todo').on('ajax:error', 'form', function(event, data) {
  //   $('.todo_lists').prepend(data.responseText);
  // });

  // data.results


