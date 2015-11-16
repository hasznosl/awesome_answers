# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  capitalize = (word) ->
    firstLettercap = word.charAt(0).toUpperCase()
    firstLettercap + word.slice(1)

  $("#texxt").on "keyup", ->
    array = $(@).val().split(" ")
    array = array.map (word) -> capitalize(word)
    $("#texxxt").html(array.join(" "))
