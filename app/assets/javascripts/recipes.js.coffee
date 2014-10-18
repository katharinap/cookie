# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addMyClasses = ->
  $( ".remove_nested_fields" ).addClass( "btn btn-default" )
  $( ".add_nested_fields" ).addClass( "btn btn-default" )

# simple form 'bug', should not add form-control to checkbox fields
fixCheckBoxes = ->
  $(':checkbox').each ->
    $(this).removeClass('form-control')
  
$(document).ready( fixCheckBoxes )
$(document).on( "page:load", fixCheckBoxes )
