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

$(document).on('ready', function(){
  $('#js-television-program-data-table, #js-channel-data-table, #data').DataTable({
    responsive: true
  });
});
