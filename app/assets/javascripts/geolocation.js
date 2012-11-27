var Geolocation = {
  init: function() {
    $('.find-shops').on('click', this.getGeoLocation);
  },

  getGeoLocation: function() {
    var getLongLat = [];
    navigator.geolocation.getCurrentPosition(function(position){
      $.ajax({
        type: 'post',
        url: '/shops',
        dataType: 'json',
        data: {longitude: position.coords.longitude, latitude: position.coords.latitude},
        success: function() {
        }
      });
    });
  }
};

$(document).ready(function(){ Geolocation.init(); });