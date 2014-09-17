jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('input[type=file]').bootstrapFileInput()
  $('.file-inputs').bootstrapFileInput()
