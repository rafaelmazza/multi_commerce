$ ->
	class IndexView extends Backbone.View
		el: $ 'body'
		
		initialize: ->
			$('.date').datepicker()
			$('.date-mask').mask("99/99/9999")
			
		events:
			"click #toggle-checkboxes": "toggle"
			"click a.bulk_action": "submitBulkForm"
      # "change #scope": "scopeChanged"
			
		toggle: ->
	    checkBoxes = $("input:checkbox:not('#toggle-checkboxes')")
	    checkBoxes.attr("checked", !checkBoxes.attr("checked"))
	
		submitBulkForm: ->
			if ($("input:checked:not('#toggle-checkboxes')").length > 0)
	      $('#bulk_form').submit()
	    else
	      alert('Nenhum item selecionado')
	    false
		
    # scopeChanged: (e) ->
    #   date_column = e.target.value
    #   console.log('q[' + date_column + '_lteq]')
    #   $('#start_date').attr('name', 'q[' + date_column + '_gteq]')
    #   $('#end_date').attr('name', 'q[' + date_column + '_lteq]')
		
	new IndexView