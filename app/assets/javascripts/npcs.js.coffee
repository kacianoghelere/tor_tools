jQuery ($) ->
  $(document).on 'ready page:load', ->
    console.log('npcs.js.coffee loaded')
    $.startMultiselects();