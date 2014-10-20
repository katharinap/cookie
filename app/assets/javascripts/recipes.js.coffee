# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addMyClasses = ->
  $( ".remove_nested_fields" ).addClass( "btn btn-default" )
  $( ".add_nested_fields" ).addClass( "btn btn-default" )

# simple form 'bug', should not add form-control to checkbox fields
updateInputFields = ->
  $(':checkbox').each ->
    $(this).removeClass('form-control')
  $('textarea').autosize();
    
$(document).ready( updateInputFields )
$(document).on( "page:load", updateInputFields )
