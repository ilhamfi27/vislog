// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap.min
//= require lodash
//= require bootstrap-select/bootstrap-select.min
//= require jquery.dataTables.min
//= require dataTables.bootstrap.min
//= require adminlte/fastclick
//= require adminlte/moment.min
//= require adminlte/daterangepicker
//= require adminlte/adminlte.min
//= require adminlte/jquery.sparkline.min
//= require adminlte/jquery-jvectormap-1.2.2.min
//= require adminlte/jquery-jvectormap-world-mill-en
//= require adminlte/jquery.slimscroll.min
//= require adminlte/Chart
//= require adminlte/demo
//= require multiselect.min
//= require video
//= require videojs-flash
//= require videojs-contrib-hls
//= require jquery-ui

function secondsToHms(d) {
  d = Number(d);
  var h = Math.round(d / 3600);
  var m = Math.round(d % 3600 / 60);
  var s = Math.round(d % 3600 % 60);

  var label = [];

  label.push(h > 0 ? h : null);
  label.push(m > 0 ? (m < 10 ? '0' + m : m) : '00');
  label.push(s > 0 ? (s < 10 ? '0' + s : s)  : '00');

  label = _.filter(label, function(l) { return l != null });
  label = label.join(':');

  return label; 
}

$(document).on('ready', function(){

  $('#js-channel-data-table, #data, #js-television-program-data-table').DataTable({
    responsive: true
  });
  $(".alert").fadeTo(2000, 500).fadeOut(1000, function(){
    $(".alert").fadeOut(1000);
  });  
});
