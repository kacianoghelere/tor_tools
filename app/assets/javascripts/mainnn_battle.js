$(document).ready(function() {
	$(document).on('click', 'button[name="adicionar"]', function(event) {
		$.id = Number($('select[name="battle[npc_id]"]').val());
		$.fetchNpcData($.id);
	});

	$(document).on('click', 'button[name="remove"]', function(event) {
		$(this).closest('tr.item-initiative').remove();
	});

	$(document).on('click', 'button[name="replicate"]', function(event) {
		$.replicate();
	});

	$(document).on('click', 'button[name="generate"]', function(event) {
		$.generateInitiatives();
	});

	$(document).on('click', 'button[name="add_party"]', function(event) {
		$.code = $(this).data('code');
		$.fetchPartyData($.code);
	});

	$(document).on('change', 'select[name="position"]', function(event) {
		$.valor   = Number($(this).val());
		$.tr      = $(this).closest('tr.item-initiative');
		$.posicao = $.searchPosition($.valor);
		$.tr.removeClass("danger info success warning");
		$.tr.addClass($.posicao.classe);
		$.calculateNA(this);
	});

	$.fetchPartiesData();
	$('[data-toggle="tooltip"]').tooltip();
});