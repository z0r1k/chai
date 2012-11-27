var Geolocation = {
  init: function() {
    $('.find-shops').on('click', this.getGeoLocation);
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

        // success: function(data) {

        //   $('body').html(data);

        // }
      });
    });
  }
};

$(document).ready(function(){
  Geolocation.init();
  $('#map-something').on('ajax:success', function(event, data) {
      // console.log(data.results)
      //debugger

      // $('#map-something').prepend(data.results);
      function lists(data){
        for (var i = 0; i < data.results.length - 1; i++) {
          $('#map-something').append("<li> " + data.results[i].join(" ") + " </li>")
        }
      };
      lists(data);
      // debugger

  });
});


  // $('.add-todo').on('ajax:error', 'form', function(event, data) {
  //   $('.todo_lists').prepend(data.responseText);
  // });

  // data.results