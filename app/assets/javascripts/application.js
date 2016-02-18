// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require bootstrap-sprockets
//= require jquery_ujs
//= require bootstrap-multiselect
// require dataTables/jquery.dataTables
//= require turbolinks
//= require_tree

$.fixNumbers = function() {
	$(document).on('keyup', '[type="number"]', function(event) {
		var v = this.value;
		if($.isNumeric(v) === false) {
			//chop off the last char entered
			this.value = this.value.replace(/[^0-9]+/g, "")
		}
	});
}

$.fixNumbers();

$.startMultiselects = function() {
	$('select[multiple="multiple"]').multiselect({
		maxHeight: 200,
		enableFiltering: false,
		includeSelectAllOption: false,
		buttonClass: 'btn btn-default btn-sm',
		buttonContainer: '<div class="btn-group" />',
		nonSelectedText: 'Selecione',
		allSelectedText: 'Todos selecionados'
	});
}
$.customMultiselects = function(elem, limit) {
	$(elem).multiselect({
		maxHeight: 200,
		enableFiltering: false,
		includeSelectAllOption: false,
		buttonClass: 'btn btn-default btn-sm',
		buttonContainer: '<div class="btn-group" />',
		nonSelectedText: 'Selecione',
		allSelectedText: 'Todos selecionados',
    onChange: function(option, checked) {
			// Get selected options.
			var selectedOptions = $(elem).find('option:selected');
			if (selectedOptions.length >= limit) {
				// Disable all other checkboxes.
				var nonSelectedOptions = $(elem).find('option').filter(function() {
					return !$(this).is(':selected');
				});

				var dropdown = $(elem).siblings('.multiselect-container');
				nonSelectedOptions.each(function() {
					var input = $('input[value="' + $(this).val() + '"]');
					input.prop('disabled', true);
					input.parent('li').addClass('disabled');
				});
			} else {
				// Enable all checkboxes.
				var dropdown = $(elem).siblings('.multiselect-container');
				$(elem).find('option').each(function() {
					var input = $('input[value="' + $(this).val() + '"]');
					input.prop('disabled', false);
					input.parent('li').addClass('disabled');
				});
			}
    }
	});
}

$.posicoes = [
	{ id: 1, titulo: "Vanguarda",  classe: "danger",  na: 6  },
	{ id: 2, titulo: "Aberta",     classe: "info",    na: 9  },
	{ id: 3, titulo: "Defensiva",  classe: "success", na: 12 },
	{ id: 4, titulo: "Retaguarda", classe: "warning", na: 12 }
];

$.adicionarItensInicio = function (qtd) {
	$.ajax({
		url: './templates/item-iniciativa.html',
		type: 'GET',
		dataType: 'html',
		success: function(data) {
			for (var i = 0; i < qtd; i++) {
				$('#iniciativa tbody').append(data);
			};
		}
	}).done(function() {
		$.gerarIds();
		$('select[name="posicao"]').trigger('change');
	});
}

$.adicionarItem = function () {
	$.ajax({
		url: './templates/item-iniciativa.html',
		type: 'GET',
		dataType: 'html',
		success: function(data) {
			$('#iniciativa tbody').append(data);
		}
	}).done(function() {
		$.gerarIds();
		$('select[name="posicao"]').trigger('change');
	});
}

$.replicar = function () {
	$.first = $('#iniciativa tbody tr.item-iniciativa:first');
	$.ajaxSetup({async: false});	
	$.adicionarItem();
	$.ajaxSetup({async: true});	
	$.last  = $('#iniciativa tbody tr.item-iniciativa:last');

	$.val = $.first.find('input[name="nome"]').val();
	$.last.find('input[name="nome"]').val($.val);

	$.val = $.first.find('input[name="ind_atributo"]').val();
	$.last.find('input[name="ind_atributo"]').val($.val);

	$.val = $.first.find('input[name="resist"]').val();
	$.last.find('input[name="resist"]').val($.val);

	$.val = $.first.find('input[name="recurso"]').val();
	$.last.find('input[name="recurso"]').val($.val);

	$.val = $.first.find('input[name="aparar"]').val();
	$.last.find('input[name="aparar"]').val($.val);

	$.val = $.first.find('input[name="escudo"]').val();
	$.last.find('input[name="escudo"]').val($.val);

	$.val = $.first.find('select[name="posicao"]').val();
	$.last.find('select[name="posicao"]').val($.val);

	$.val = $.first.find('select[name="armadura"]').val();
	$.last.find('select[name="armadura"]').val($.val);

	$.val = $.first.find('input[name="iniciativa"]').val();
	$.last.find('input[name="iniciativa"]').val($.val);

	$.val = $.first.find('input[name="total"]').val();
	$.last.find('input[name="total"]').val($.val);

	$('select[name="posicao"]').trigger('change');
}

$.gerarIds = function () {
	$('tr.item-iniciativa').each(function(i, tr) {
		$(tr).attr('id', 'item-iniciativa-'+i);
		$(tr).find('input[name="nome"]').attr('id', 'nome-'+i);
		$(tr).find('input[name="ind_atributo"]').attr('id', 'ind_atributo-'+i);
		$(tr).find('input[name="resist"]').attr('id', 'resist-'+i);
		$(tr).find('input[name="recurso"]').attr('id', 'recurso-'+i);
		$(tr).find('input[name="aparar"]').attr('id', 'aparar-'+i);
		$(tr).find('input[name="escudo"]').attr('id', 'escudo-'+i);
		$(tr).find('select[name="armadura"]').attr('id', 'posicao-'+i);
		$(tr).find('select[name="posicao"]').attr('id', 'posicao-'+i);
		$(tr).find('input[name="iniciativa"]').attr('id', 'iniciativa-'+i);
		$(tr).find('input[name="total"]').attr('id', 'total-'+i);
	});
}

$.calcularNA = function (element) {
	$.tr      = $(element).closest('tr.item-iniciativa');
	$.apa     = $.tr.find('input[name="aparar"]').val();
	$.esc     = $.tr.find('input[name="escudo"]').val();
	$.pos     = $.tr.find('select[name="posicao"]').val();
	$.posicao = $.buscaPosicao(Number($.pos));
	$.total   = Number($.apa) + Number($.esc) + $.posicao.na;
	$.tr.find('input[name="total"]').val($.total);
}

$.gerarIniciativas = function () {
	$('tr.item-iniciativa').each(function(i, tr) {
		$.rand = $.getRandom(6);
		$(tr).find('input[name="iniciativa"]').val($.rand);
	});
}

$.getRandom = function (limit) {
	return Math.floor((Math.random() * limit) + 1); 
}

$.autocomplete = function (id_element, label_element, url) {
    $(label_element).autocomplete({
        source: function (request, response) {
            $.ajax({
                url: url,
                dataType: "json",
                data: {
                    term: request.term
                },
                success: function (data) {
                    response($.map(data.dados, function (item) {
                        return {
                            id: item.id,
                            label: item.label
                        };
                    }));
                }
            });
        },
        position: {
            collision: "flip"
        },
        select: function (event, ui) {
            $(id_element).val(ui.item.id);
            $(label_element).val(ui.item.label);
            event.preventDefault();
        },
        focus: function (event) {
            event.preventDefault();
            return false;
        },
        change: function (event, ui) {
            if (ui.item == null) {
                $(id_element).val('');
                $(this).val('');
            }
        },
        minLength: 3,
        delay: 500
    });
}