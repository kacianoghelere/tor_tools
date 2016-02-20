
$.posicoes = [
	{ id: 1, titulo: "Vanguarda",  classe: "danger",  na: 6  },
	{ id: 2, titulo: "Aberta",     classe: "info",    na: 9  },
	{ id: 3, titulo: "Defensiva",  classe: "success", na: 12 },
	{ id: 4, titulo: "Retaguarda", classe: "warning", na: 12 }
];

$.buscaPosicao = function(id) {
    var result = $.posicoes.filter(function(val, i) {
        return val.id === id;
    });
    return result[0];
};

$.gerarItemIniciativa = function (data) {
	$.tr                = $('<tr />', {class: "item-iniciativa"});
	$.td_remover        = $('<td />');
	$.td_nome           = $('<td />');
	$.td_ind_attr       = $('<td />');
	$.td_resist_inicial = $('<td />');
	$.td_resist         = $('<td />');
	$.td_recurso        = $('<td />');
	$.td_aparar         = $('<td />');
	$.td_armadura       = $('<td />');
	$.td_posicao        = $('<td />');
	$.td_iniciativa     = $('<td />');
	$.td_total          = $('<td />');
	//--------------------------------------------------------------------------
	// REMOVER
	$.btn_remover = $('<button />', {
		name:  "remover",
		id:    "remover",
		class: "btn btn-danger btn-sm btn-block",
		html:  "<span class='glyphicon glyphicon-remove'></span>"
	});
	$.btn_remover.appendTo($.td_remover);
	//--------------------------------------------------------------------------
	// NOME
	$.select_nome = $('<select />', {
		name:  "nome",
		id:    "nome",
		class: "form-control input-sm calc"
	});
	$.select_nome.appendTo($.td_nome);
	//--------------------------------------------------------------------------
	// IND_ATRIBUTO
	$.input_ind_attr = $('<input />', {
		type:      "numero",
		name:      "ind_atributo",
		id:        "ind_atributo",
		class:     "form-control input-sm",
		readonly:  true,
		maxlength: "2",
		value:     (data ? data.ind_attr : 0)
	});
	$.input_ind_attr.appendTo($.td_ind_attr);
	//--------------------------------------------------------------------------
	// RESIST_INICIAL
	$.input_resist_inicial = $('<input />', {
		type:      "numero",
		name:      "resist_inicial",
		id:        "resist_inicial",
		class:     "form-control input-sm",
		readonly:  true,
		maxlength: "3",
		value:     (data ? data.resist : 0)
	});
	$.input_resist_inicial.appendTo($.td_resist_inicial);
	//--------------------------------------------------------------------------
	// RESIST
	$.input_resist = $('<input />', {
		type:      "numero",
		name:      "resist",
		id:        "resist",
		class:     "form-control input-sm",
		maxlength: "3",
		value:     (data ? data.resist : 0)
	});
	$.input_resist.appendTo($.td_resist);
	//--------------------------------------------------------------------------
	// RECURSO
	$.input_recurso = $('<input />', {
		type:      "numero",
		name:      "recurso",
		id:        "recurso",
		class:     "form-control input-sm",
		maxlength: "2",
		value:     (data ? data.recurso : 0)
	});
	$.input_recurso.appendTo($.td_recurso);
	//--------------------------------------------------------------------------
	// APARAR
	$.input_aparar = $('<input />', {
		type:      "numero",
		name:      "aparar",
		id:        "aparar",
		class:     "form-control input-sm",
		readonly:  true,
		maxlength: "2",
		value:     (data ? data.aparar : 0)
	});
	$.input_aparar.appendTo($.td_aparar);
	//--------------------------------------------------------------------------
	// ARMADURA
	$.input_armadura = $('<input />', {
		type:      "numero",
		name:      "armadura",
		id:        "armadura",
		class:     "form-control input-sm",
		readonly:  true,
		maxlength: "2",
		value:     (data ? data.aparar : 0)
	});
	$.input_armadura.appendTo($.td_armadura);
	//--------------------------------------------------------------------------
	// POSICAO
	$.select_posicao = $('<select />', {
		name:  "posicao",
		id:    "posicao",
		class: "form-control input-sm calc"
	});
	$.each($.posicoes, function(index, val) {
		 $.option_posicao = $('<option />', {
			value: val.id,
			html:  val.titulo
		});
		$.option_posicao.appendTo($.select_posicao);
	});
	$.select_posicao.appendTo($.td_posicao);
	//--------------------------------------------------------------------------
	// INICIATIVA
	$.input_iniciativa = $('<input />', {
		type:      "numero",
		name:      "iniciativa",
		id:        "iniciativa",
		class:     "form-control input-sm",
		maxlength: "2",
		value:     "0",
		disabled:  true
	});
	$.input_iniciativa.appendTo($.td_iniciativa);
	//--------------------------------------------------------------------------
	// TOTAL
	$.input_total = $('<input />', {
		type:      "numero",
		name:      "total",
		id:        "total",
		class:     "form-control input-sm",
		maxlength: "2",
		value:     "0",
		disabled:  true
	});
	$.input_total.appendTo($.td_total);

	$.td_remover.appendTo($.tr);
	$.td_nome.appendTo($.tr);
	$.td_ind_attr.appendTo($.tr);
	$.td_resist_inicial.appendTo($.tr);
	$.td_resist.appendTo($.tr);
	$.td_recurso.appendTo($.tr);
	$.td_aparar.appendTo($.tr);
	$.td_armadura.appendTo($.tr);
	$.td_posicao.appendTo($.tr);
	$.td_iniciativa.appendTo($.tr);
	$.td_total.appendTo($.tr);
	return $.tr;
}

$.adicionarItensInicio = function (qtd) {
	for (var i = 0; i < qtd; i++) {
		$.item = $.gerarItemIniciativa(null);
		$('#iniciativa tbody').append($.item);
		$.gerarIds();
		$('select[name="posicao"]').trigger('change');
	};
}

$.adicionarItem = function () {
	$.item = $.gerarItemIniciativa(null);
	$('#iniciativa tbody').append($.item);
	$.gerarIds();
	$('select[name="posicao"]').trigger('change');
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
