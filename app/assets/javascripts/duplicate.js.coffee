jQuery ($) ->
  $(document).on 'ready page:load', ->
    console.log('duplicate.js.coffee loaded')
    if $('.duplicatable').length

      nested = $('.duplicatable').last().clone()

      $(".destroy_duplicate:first").remove()

      $('body').on 'click','.destroy_dup', (e) ->
        $(this).closest('.duplicatable').slideUp().remove()

      $('.duplicate').click (e) ->
        e.preventDefault()
        lastnested = $('.duplicatable').last()
        newnested  = $(nested).clone()
        formsOnPage = $('.duplicatable').length

        $(newnested).find('.nested_id').each ->
          $(this).val ''
        $(newnested).find('select, input').each ->
          oldId = $(this).attr 'id'
          newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
          $(this).attr 'id', newId

          oldName = $(this).attr 'name'
          newName = oldName.replace(new RegExp(/\[[0-9]+\]/),"[#{formsOnPage}]")
          $(this).attr 'name', newName

        $(newnested).insertAfter(lastnested)