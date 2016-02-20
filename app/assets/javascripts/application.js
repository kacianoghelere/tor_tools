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