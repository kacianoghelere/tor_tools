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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require bootstrap-multiselect
// require dataTables/jquery.dataTables
//= require turbolinks
//= require_tree .

// $(document).on('keyup', '[type="number"]', function(event) {
//		 var v = this.value;
//		 if($.isNumeric(v) === false) {
//				 //chop off the last char entered
//				 this.value = this.value.replace(/[^0-9\.]+/g, "")
//		 }
// });

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