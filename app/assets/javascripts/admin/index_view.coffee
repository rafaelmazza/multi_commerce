$ ->
	class IndexView extends Backbone.View
		el: $ 'body'
		
		initialize: ->
			$('.date').datepicker()
			$('.date-mask').mask("99/99/9999")
			
		events:
			"click #toggle-checkboxes": "toggle"
			"click a.bulk_action": "submitBulkForm"
			
		toggle: ->
	    checkBoxes = $("input:checkbox:not('#toggle-checkboxes')")
	    checkBoxes.attr("checked", !checkBoxes.attr("checked"))
	
		submitBulkForm: ->
			if ($('input:checked').length > 0)
	      $('#bulk_form').submit()
	    else
	      alert('nothing selected')
	    false
		
	new IndexView