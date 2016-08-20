function checkYouTubeUrl(url) {
  if (!url) {
    alert('YouTube の URL を入力願います');
    return false;
  }
  // Parse YouTube URL
  var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
  var match = url.match(regExp);
  if (match&&match[7].length==11){
    var youtube_embedded_video_url = location.protocol + "//www.youtube.com/embed/" + match[7] + "?rel=0";
    $('#youtubePreview iframe').attr('src', youtube_embedded_video_url);
    $('#youtubePreview').show();
  } else {
    alert('URL が正しくありません');
  }
}

function autoHeightTextarea(parent) {
  var txt = $(parent + " textarea.auto-height");

  if (txt.length == 0) return false;
  
  txt.height(txt[0].scrollHeight);

  $(function() {
    var hiddenDiv = $(document.createElement('div')),
      content = null;

    txt.addClass('txtstuff');
    hiddenDiv.addClass('hiddendiv common');

    $(parent + ' .form-group.text').append(hiddenDiv);

    txt.on('input', function () {

      content = $(this).val();

      content = content.replace(/\n/g, '<br>');
      hiddenDiv.html(content + ' <br> ');

      $(this).css('height', hiddenDiv.height());

    });
  });
}
