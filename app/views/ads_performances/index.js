$('#video-download-wrapper').html('<%= escape_javascript(render("shared/show_modal_for_video_downloading")) %>');
$('.video-download-modal').modal('show');

var adsPerfDataTable = $('#js-television-program-data-table').DataTable({
  responsive: true,
  "scrollX": true
});

$('input.js-table-checkbox').on( 'change', function (e) {
  e.preventDefault();
  var selectedColumn = adsPerfDataTable.columns( $(this).attr('data-column') );
  if($('input.js-table-checkbox:checked').length == 0){
    adsPerfDataTable.columns([0,1,2,3,4,5,6,7,8,9,10]).visible(true);
  } else {
    adsPerfDataTable.columns([0,1,2,3,4,5,6,7,8,9,10]).visible( false, false );
    adsPerfDataTable.columns.adjust().draw( false );
    $('input.js-table-checkbox:checked').each(function(){
      adsPerfDataTable.columns( $(this).attr('data-column') ).visible(true);
    });
  }
});