jQuery ($) ->
  $(document).on 'ready page:load', ->
    console.log('main_battle.js.coffee loaded')
    $.fetchPartiesData();
    $('[data-toggle="tooltip"]').tooltip()

    $('button[name="adicionar"]').click (event) ->
      $.id = Number($('select[name="battle[npc_id]"]').val())
      $.fetchNpcData $.id
      return

    $('button[name="remove"]').click (event) ->
      $(this).closest('tr.item-initiative').remove()
      return

    $('button[name="replicate"]').click  (event) ->
      $.replicate()
      return

    $('button[name="generate"]').click (event) ->
      $.generateInitiatives()
      return

    $('button[name="add_party"]').click (event) ->
      $.code = $(this).data('code')
      $.fetchPartyData $.code
      return

    $('select[name="position"]').change (event) ->
      $.valor = Number($(this).val())
      $.tr = $(this).closest('tr.item-initiative')
      $.posicao = $.searchPosition($.valor)
      $.tr.removeClass 'danger info success warning'
      $.tr.addClass $.posicao.classe
      $.calculateNA this
      return