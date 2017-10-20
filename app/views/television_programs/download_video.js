$('#video-downloader-wrapper').html('<%= escape_javascript(render("shared/show_video_downloader")) %>');
$('.js-video-downloader').modal('show');
$('.video-download-modal').modal('hide');

var player = videojs('js-video-player', {
  controls: true,
  autoplay: false,
  preload: 'auto'
});

$("#video-modal-wrapper .close-modal").on('click', function(){ 
  $(".js-video-downloader").html("");
  $(".js-video-downloader").modal('hide');
});

$('.js-video-downloader').on('shown.bs.modal', function(){
  window.timeRanges = [];

  function setSliderLabel() {
    $( "#amount" ).val( 
      secondsToHms($( "#video-length-slider-range" ).slider( "values", 0 )) + 
      " - " +
      secondsToHms($( "#video-length-slider-range" ).slider( "values", 1 ))
    )
  }

  $('.js-video-downloader .js-cut-video-button').on('click', function(){
    var start, end, displayStart, displayEnd;

    start        = $( "#video-length-slider-range" ).slider( "values", 0 );
    end          = $( "#video-length-slider-range" ).slider( "values", 1 );
    displayStart = secondsToHms($( "#video-length-slider-range" ).slider( "values", 0 ));
    displayEnd   = secondsToHms($( "#video-length-slider-range" ).slider( "values", 1 ));

    window.timeRanges.push([start, end]);

    result = '<p>' + window.timeRanges.length + '. ' + displayStart + ' - ' +displayEnd + '</p>'

    $('.js-video-downloader .js-cut-result').append(result);
  })
  
  downloadButton = $('.js-video-downloader .js-download-cutted-videos')

  downloadButton.on('click', function(){
    $.ajax({
      url: '/ads_performances/download_cutted_videos.js',
      method: 'GET',
      data: { 
        time_ranges: window.timeRanges, 
        television_program_id:  "<%= @television_program.id %>"
      },
      beforeSend: function(){
        downloadButton.attr('disabled', true);
        downloadButton.html('Processing..');
      },
      success: function(url){
        downloadButton.attr('disabled', false);
        downloadButton.html('Download');
      },
      error: function(){
        alert('Something went wrong..!')
        downloadButton.attr('disabled', false);
        downloadButton.html('Download');
      }
    })
  })

   

  $( "#video-length-slider-range" ).slider({
    range: true,
    min: 0,
    step: 1,
    max: player.duration(),
    values: [ 75, 300 ],
    create: setSliderLabel,   
    slide: setSliderLabel,
    change: setSliderLabel
  });
})