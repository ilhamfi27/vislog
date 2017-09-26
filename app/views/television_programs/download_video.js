$('#video-downloader-wrapper').html('<%= escape_javascript(render("shared/show_video_downloader")) %>');
$('.css-video-downloader').modal('show');
$('.video-download-modal').modal('hide');

$("#video-modal-wrapper .close-modal").on('click', function(){ 
   $(".css-video-downloader").html("");
   $(".css-video-downloader").modal('hide');
});