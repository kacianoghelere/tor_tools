$(document).on('keyup', '[type="number"]', function(event) {
	var v = this.value;
	if($.isNumeric(v) === false) {
		//chop off the last char entered
		this.value = this.value.replace(/[^0-9]+/g, "")
	}
});

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