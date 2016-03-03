jQuery ($) ->
  $(document).on 'ready page:load', ->
    console.log('main.js.coffee loaded')
    $('[data-toggle="tooltip"]').tooltip()

    $('button[name="adicionar"]').click (event) ->
      $.id = Number($('select[name="battle[npc_id]"]').val())
      $.fetchNpcData $.id
      return

    $('body').on 'click','button[name="remove"]', (event) ->
      console.log($(this))
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

$.posicoes = [
  {
    id: 1
    titulo: 'Vanguarda'
    classe: 'danger'
    na: 6
  }
  {
    id: 2
    titulo: 'Aberta'
    classe: 'info'
    na: 9
  }
  {
    id: 3
    titulo: 'Defensiva'
    classe: 'success'
    na: 12
  }
  {
    id: 4
    titulo: 'Retaguarda'
    classe: 'warning'
    na: 12
  }
]

$.searchPosition = (id) ->
  result = $.posicoes.filter((val, i) ->
    val.id == id
  )
  result[0]

$.generateItemInitiative = (data) ->
  console.log data
  $.tr = $('<tr />', class: 'item-initiative')
  $.td_npc = $('<td />')
  $.td_attr_index = $('<td />')
  $.td_resistance = $('<td />')
  $.td_resource = $('<td />')
  $.td_parry = $('<td />')
  $.td_armour = $('<td />')
  $.td_position = $('<td />')
  $.td_initiative = $('<td />')
  $.td_total = $('<td />')
  #--------------------------------------------------------------------------
  # BOTOES
  $.btn_remover = $('<button />',
    name: 'remove'
    id: 'remove'
    class: 'btn btn-danger btn-sm'
    html: '<span class=\'glyphicon glyphicon-minus\'></span>')
  #--------------------------------------------------------------------------
  # NOME
  $.input_group_npc = $('<div />', class: 'input-group input-group-sm')
  $.span_info_npc = $('<span />',
    class: 'input-group-addon npc_info_popover'
    'data-code': if data then data.id else ''
    html: '<span class=\'glyphicon glyphicon-info-sign\'></span>')
  $.span_desc_npc = $('<span />',
    class: 'input-group-addon npc_desc_popover'
    'data-code': if data then data.id else ''
    html: '<span class=\'glyphicon glyphicon-align-left\'></span>')
  $.span_btn = $('<span />', class: 'input-group-btn')
  $.span_skill_npc = $('<span />',
    class: 'input-group-addon npc_skill_popover'
    'data-code': if data then data.id else ''
    html: '<span class=\'glyphicon glyphicon-list-alt\'></span>')
  $.btn_remover.appendTo $.span_btn
  $.span_btn.appendTo $.input_group_npc
  $.span_info_npc.appendTo $.input_group_npc
  $.span_desc_npc.appendTo $.input_group_npc
  $.initializeInfoPopover $.span_info_npc
  $.initializeDescPopover $.span_desc_npc
  $.initializeSkillPopover $.span_skill_npc
  $.input_npc = $('<input />',
    type: 'text'
    name: 'npc'
    id: 'npc'
    class: 'form-control input-sm'
    readonly: true
    value: if data then data.name else '')
  $.input_npc.appendTo $.input_group_npc
  $.span_skill_npc.appendTo $.input_group_npc
  $.input_group_npc.appendTo $.td_npc
  #--------------------------------------------------------------------------
  # attr_index
  $.input_attr_index = $('<input />',
    type: 'number'
    name: 'attr_index'
    id: 'attr_index'
    class: 'form-control input-sm'
    readonly: true
    maxlength: '2'
    value: if data then data.attr_index else 0)
  $.input_attr_index.appendTo $.td_attr_index
  #--------------------------------------------------------------------------
  # resistance
  $.input_group_resistance = $('<div />', class: 'input-group input-group-sm')
  $.span_resistance = $('<span />',
    class: 'input-group-addon'
    html: if data then data.resistance else 0)
  $.input_resistance = $('<input />',
    type: 'number'
    name: 'resistance'
    id: 'resistance'
    class: 'form-control input-sm'
    maxlength: '3'
    value: if data then data.resistance else 0)
  $.span_resistance.appendTo $.input_group_resistance
  $.input_resistance.appendTo $.input_group_resistance
  $.input_group_resistance.appendTo $.td_resistance
  #--------------------------------------------------------------------------
  # resource
  $.input_resource = $('<input />',
    type: 'number'
    name: 'resource'
    id: 'resource'
    class: 'form-control input-sm'
    maxlength: '2'
    value: if data then data.resource else 0)
  $.input_resource.appendTo $.td_resource
  #--------------------------------------------------------------------------
  # parry
  $.input_parry = $('<input />',
    type: 'number'
    name: 'parry'
    id: 'parry'
    class: 'form-control input-sm'
    readonly: true
    maxlength: '2'
    value: if data then data.parry else 0)
  $.input_parry.appendTo $.td_parry
  #--------------------------------------------------------------------------
  # armour
  $.input_armour = $('<input />',
    type: 'number'
    name: 'armour'
    id: 'armour'
    class: 'form-control input-sm'
    readonly: true
    maxlength: '2'
    value: if data then data.parry else 0)
  $.input_armour.appendTo $.td_armour
  #--------------------------------------------------------------------------
  # position
  $.select_position = $('<select />',
    name: 'position'
    id: 'position'
    class: 'form-control input-sm calc')
  $.each $.posicoes, (index, val) ->
    $.option_position = $('<option />',
      value: val.id
      html: val.titulo)
    $.option_position.appendTo $.select_position
    return
  $.select_position.appendTo $.td_position
  #--------------------------------------------------------------------------
  # initiative
  $.input_initiative = $('<input />',
    type: 'number'
    name: 'initiative'
    id: 'initiative'
    class: 'form-control input-sm'
    maxlength: '2'
    value: '0'
    disabled: true)
  $.input_initiative.appendTo $.td_initiative
  #--------------------------------------------------------------------------
  # TOTAL
  $.input_total = $('<input />',
    type: 'number'
    name: 'total'
    id: 'total'
    class: 'form-control input-sm'
    maxlength: '2'
    value: '0'
    disabled: true)
  $.input_total.appendTo $.td_total
  $.td_npc.appendTo $.tr
  $.td_attr_index.appendTo $.tr
  $.td_resistance.appendTo $.tr
  $.td_resource.appendTo $.tr
  $.td_parry.appendTo $.tr
  $.td_armour.appendTo $.tr
  $.td_position.appendTo $.tr
  $.td_initiative.appendTo $.tr
  $.td_total.appendTo $.tr
  $.tr

$.adicionarItensInicio = (qtd) ->
  i = 0
  while i < qtd
    $.item = $.generateItemInitiative(null)
    $('#initiative tbody').append $.item
    $.gerarIds()
    $('select[name="position"]').trigger 'change'
    i++
  return

$.adicionarItem = ->
  $.item = $.generateItemInitiative(null)
  $('#initiative tbody').append $.item
  $.gerarIds()
  $('select[name="position"]').trigger 'change'
  return

$.replicate = ->
  $.last = $('#initiative tbody tr.item-initiative:last')
  $('#initiative tbody').append $.last.clone()
  $.gerarIds()
  $('tr.item-initiative').each (i, tr) ->
    $.info  = $(tr).find('.npc_info_popover')
    $.initializeInfoPopover($.info)
    $.desc = $(tr).find('.npc_desc_popover')
    $.initializeDescPopover($.desc)
    $.skill = $(tr).find('.npc_skill_popover')
    $.initializeSkillPopover($.skill)
  $('select[name="position"]').trigger 'change'
  return

$.gerarIds = ->
  $('tr.item-initiative').each (i, tr) ->
    $(tr).attr 'id', 'item-initiative-' + i
    $(tr).find('input[name="npc"]').attr 'id', 'npc-' + i
    $(tr).find('input[name="attr_index"]').attr 'id', 'attr_index-' + i
    $(tr).find('input[name="resistance"]').attr 'id', 'resistance-' + i
    $(tr).find('input[name="resource"]').attr 'id', 'resource-' + i
    $(tr).find('input[name="parry"]').attr 'id', 'parry-' + i
    $(tr).find('input[name="escudo"]').attr 'id', 'escudo-' + i
    $(tr).find('select[name="armour"]').attr 'id', 'position-' + i
    $(tr).find('select[name="position"]').attr 'id', 'position-' + i
    $(tr).find('input[name="initiative"]').attr 'id', 'initiative-' + i
    $(tr).find('input[name="total"]').attr 'id', 'total-' + i
    $(tr).find('.npc_info_popover').attr 'id', 'npc_info_popover-' + i
    $(tr).find('.npc_skill_popover').attr 'id', 'npc_skill_popover-' + i
    return
  return

$.calculateNA = (element) ->
  $.tr = $(element).closest('tr.item-initiative')
  $.apa = $.tr.find('input[name="parry"]').val()
  $.pos = $.tr.find('select[name="position"]').val()
  $.position = $.searchPosition(Number($.pos))
  $.total = Number($.apa) + $.position.na
  $.tr.find('input[name="total"]').val $.total
  return

$.generateInitiatives = ->
  $('tr.item-initiative').each (i, tr) ->
    $.rand = $.getRandom(6)
    $(tr).find('input[name="initiative"]').val $.rand
    return
  return

$.getRandom = (limit) ->
  Math.floor Math.random() * limit + 1

$.setAjaxAsync = (value) ->
  $.ajaxSetup async: value
  return

$.npc_popover_template = '<div class="popover" role="tooltip" style="min-width: 700px">' + '<div class="arrow"></div>' + '<div class="popover-title"></div>' + '<div class="popover-content"></div>' + '</div>'
# Formata dados do npc

$.formatNpcInfo = (data) ->
  $.html = $('<div />', class: 'col-md-12 col-thin')
  if data
    $.div_img = $('<div />', class: 'col-md-12 col-thin')
    $.div_info = $('<div />', class: 'col-md-12 col-thin')
    $.panel_info = $('<div />',
      class: 'panel panel-default'
      style: 'font-size: 75%')
    $.panel_body_info = $('<div />', class: 'panel-body panel-columns')
    $.panel_head_info = $('<div />',
      class: 'panel-heading'
      html: "<b>Informações de #{data.name}</b>")

    $.img = $('<img />',
      src: data.img_url
      class: 'img-thumbnail'
      style: 'width: 48px; height: 48px; margin-right: 10px')
    $.img.prependTo $.panel_head_info
    # -------------------------------------------------------------------------
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-12 col-header text-center'
      html: '<b>Dados essênciais</b>')
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Ind. Atributo:</b> ' + data.attr_index)
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Aliado:</b> ' + data.ally)
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    # -------------------------------------------------------------------------
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-12 col-header text-center'
      html: '<b>Perícias</b>')
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Personalidade: </b>' + $.getDiams(data.personality))
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Sobrevivência: </b>' + $.getDiams(data.survival))
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Movimento: </b>' + $.getDiams(data.movement))
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Costumes: </b>' + $.getDiams(data.custom))
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Percepção: </b>' + $.getDiams(data.perception))
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-6 text-center'
      html: '<b>Ocupação: </b>' + $.getDiams(data.vocation))
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    # -------------------------------------------------------------------------
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-12 col-header text-center'
      html: '<b>Armas</b>')
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    $.div_row = $('<div />', class: 'row-fluid')
    $.div = $('<div />',
      class: 'col-md-4 col-header text-center'
      html: '<b>Nome</b>')
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-1 col-header text-center'
      html: '<b>Bonus</b>')
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-1 col-header text-center'
      html: '<b>Dano</b>')
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-1 col-header text-center'
      html: '<b>Gume</b>')
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-2 col-header text-center'
      html: '<b>Trauma</b>')
    $.div.appendTo $.div_row
    $.div = $('<div />',
      class: 'col-md-3 col-header text-center'
      html: '<b>Atq. Direcionado</b>')
    $.div.appendTo $.div_row
    $.div_row.appendTo $.panel_body_info
    $.each data.equipments, (index, equipment) ->
      $.div_row = $('<div />', class: 'row-fluid')
      $.div = $('<div />',
        class: 'col-md-4 text-center'
        html: equipment.weapon.name)
      $.div.appendTo $.div_row
      $.div = $('<div />',
        class: 'col-md-1 text-center'
        html: $.getDiams(equipment.bonus))
      $.div.appendTo $.div_row
      $.div = $('<div />',
        class: 'col-md-1 text-center'
        html: equipment.weapon.damage)
      $.div.appendTo $.div_row
      $.div = $('<div />',
        class: 'col-md-1 text-center'
        html: equipment.weapon.edge)
      $.div.appendTo $.div_row
      $.div = $('<div />',
        class: 'col-md-2 text-center'
        html: equipment.weapon.injury)
      $.div.appendTo $.div_row
      $.div = $('<div />',
        class: 'col-md-3 text-center'
        html: if equipment.weapon.weapon_category.effect then equipment.weapon.weapon_category.effect else '--')
      $.div.appendTo $.div_row
      $.div_row.appendTo $.panel_body_info
      return
    $.panel_head_info.appendTo $.panel_info
    $.panel_body_info.appendTo $.panel_info
    $.panel_info.appendTo $.div_info
    $.div_info.appendTo $.html
  $.html

# Formata dados de desc

$.formatNpcDesc = (data) ->
  $.list = '<ul class="list-group" style="margin-bottom: 0;">'
  if data
    $.list += '<li class="list-group-item list-group-item-small">' 
    $.list += data.description
    $.list += '</li>'
  else
    $.list += '<li class="list-group-item list-group-item-small">' 
    $.list += 'Nenhuma informação encontrada'
    $.list += '</li>'
  $.list += '</ul>'
  $.list

# Formata dados de skills

$.formatNpcSkills = (data) ->
  $.list = '<ul class="list-group" style="margin-bottom: 0;">'
  if data
    $.each data, (index, val) ->
      $.list += "<li class='list-group-item list-group-item-small'>" 
      $.list += "  <h6><b>#{val.name}</b> (Custo: #{val.cost})</h6>"
      $.list += "  <p>#{val.description}</p>"
      $.list += "</li>"
      return
  else
    $.list += '<li class="list-group-item list-group-item-small">' 
    $.list += 'Nenhuma informação encontrada'
    $.list += '</li>'
  $.list += '</ul>'
  $.list

# Incializa os popovers de outras despesas nas guias

$.initializeInfoPopover = (elem) ->
  $.code = $(elem).data('code')
  $.url = "npcs/#{$.code}.json"
  $.setAjaxAsync false
  $.getJSON($.url).done (data) ->
    $.info = $.formatNpcInfo(data)
    $.popover = $(elem).popover(
      'trigger': 'hover'
      'placement': 'bottom'
      'delay':
        show: '100'
        hide: '100'
      'html': true
      'container': 'body'
      'template': $.npc_popover_template
      'content': $.info).on('shown.bs.popover', ->
      # Executa controle de fechar
      $(this).parent().find('div.popover .close').on 'click', (e) ->
        $(this).popover 'hide'
        return
      return
    )
    return
  $.setAjaxAsync true
  return

# Incializa os popovers de outras despesas nas guias

$.initializeDescPopover = (elem) ->
  $.code = $(elem).data('code')
  $.url = "npcs/#{$.code}.json"
  $.setAjaxAsync false
  $.getJSON($.url).done (data) ->
    $.desc = $.formatNpcDesc(data)
    $.popover = $(elem).popover(
      'trigger': 'hover'
      'placement': 'bottom'
      'delay':
        show: '100'
        hide: '100'
      'html': true
      'title': 'Descrição'
      'container': 'body'
      'template': $.npc_popover_template
      'content': $.desc).on('shown.bs.popover', ->
      # Executa controle de fechar
      $(this).parent().find('div.popover .close').on 'click', (e) ->
        $(this).popover 'hide'
        return
      return
    )
    return
  $.setAjaxAsync true
  return

# Incializa os popovers de outras despesas nas guias

$.initializeSkillPopover = (elem) ->
  $.code = $(elem).data('code')
  $.url = "npcs/#{$.code}/skills.json"
  $.setAjaxAsync false
  $.getJSON($.url).done (data) ->
    $.skills = $.formatNpcSkills(data)
    $.popover = $(elem).popover(
      'trigger': 'hover'
      'placement': 'bottom'
      'delay':
        show: '100'
        hide: '100'
      'html': true
      'title': 'Habilidades'
      'container': 'body'
      'template': $.npc_popover_template
      'content': $.skills).on('shown.bs.popover', ->
      # Executa controle de fechar
      $(this).parent().find('div.popover .close').on 'click', (e) ->
        $(this).popover 'hide'
        return
      return
    )
    return
  $.setAjaxAsync true
  return

$.formatParties = (data) ->
  $.ul = $('<ul />', class: 'list-group list-group-scrolled-300')
  if data.length
    $.each data, (index, val) ->
      $.li = $('<li />', class: 'list-group-item')
      $.div_btn = $('<div />', class: 'pull-right')
      $.btn = $('<button />',
        type: 'button'
        html: 'Adicionar'
        name: 'add_party'
        "data-code": val.id,
        class: 'btn btn-default btn-sm')
      $.btn.appendTo $.div_btn
      $.div_btn.appendTo $.li
      $.h4 = $('<h4 />', html: "<b>#{val.id} - #{val.title}</b>")
      $.h4.appendTo $.li
      $.each val.npcs, (index, npc) ->
        $.p = $('<p />', html: npc)
        $.p.appendTo $.li
        return
      $.li.appendTo $.ul
      return
  else
    $.li = $('<li />', class: 'list-group-item')
    $.h4 = $('<h4 />', html: 'Nenhuma informação encontrada')
    $.h4.appendTo $.li
    $.li.appendTo $.ul
  $.ul

$.formatNpcs = (data, selected) ->
  $.select = $('<select />',
    class: 'form-control input-sm calc'
    name: 'npc'
    id: 'npc')
  if data.length
    $.each data, (index, val) ->
      $.option = $('<option />',
        value: val.id
        html: val.label)
      if selected and val.id == selected
        $.option.prop 'selected', true
      $.option.appendTo $.select
      return
  else
    $.option = $('<option />',
      value: ''
      html: 'Nenhuma npc encontrado')
    $.option.appendTo $.select
  $.select

$.fetchPartiesData = ->
  $.setAjaxAsync false
  $.getJSON('parties.json').done (data) ->
    $.parties = $.formatParties(data)
    $.modal_body = $('#modal-party .modal-body')
    $.parties.appendTo $.modal_body
    return
  $.setAjaxAsync true
  return

# Fetch npc data

$.fetchNpcData = (id) ->
  $.url = "npcs/#{id}.json"
  $.setAjaxAsync false
  $.getJSON($.url).done (data) ->
    $.item = $.generateItemInitiative(data)
    $('#initiative tbody').append $.item
    $.initializeInfoPopover()
    $.initializeSkillPopover()
    $.gerarIds()
    $('select[name="position"]').trigger 'change'
    return
  $.setAjaxAsync true
  return

# Fetch party data

$.fetchPartyData = (id) ->
  $.url = "parties/#{id}/party_npcs.json"
  $.setAjaxAsync false
  $.getJSON($.url).done (data) ->
    $.each data, (index, member) ->
      if member
        i = 0
        while i < member.amount
          $.item = $.generateItemInitiative(member.npc)
          $('#initiative tbody').append $.item
          $.initializeInfoPopover()
          $.initializeSkillPopover()
          $.gerarIds()
          $('select[name="position"]').trigger 'change'
          i++
      return
    return
  $.setAjaxAsync true
  return

# ---
# generated by js2coffee 2.1.0