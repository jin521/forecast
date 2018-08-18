// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $('.js-get-forecast').click(function(event){
    event.preventDefault();
    $('#prompt').hide();
    $('#table-title').show();
    var cityName = $(this).data('city');
    $('#city-name').text(cityName);
    $( "#results" ).empty();

    var loading = $('<img>').attr('src', "/assets/loading10.gif");
    $('#container').append(loading);

    $.get('/weather/' + cityName).then(function(data) {
      console.log(data)
      loading.remove();

      var results = $( "#results" );

      data.forEach(function(forecast) {
        var element = $(
        '<tr class="looking-cool">'
        + '<td class="table-primary">' + forecast.date + '</td>'
        + '<td class="table-primary">' + forecast.day + '</td>'
        + '<td class="table-primary">' + forecast.high + '</td>'
        + '<td class="table-primary">' + forecast.low + '</td>'
        + '<td class="table-primary">' + forecast.description + '</td>'
        + '</tr>');
        results.append(element);
      });
    });

    return false;
  });
});
