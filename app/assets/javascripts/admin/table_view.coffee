$ ->
  class TableView extends Backbone.View
    el: $ '.table'
    # initialize: ->
    #   console.log('table')
    events:
      "click tr": "show"
    show: (e)->
      url = $(e.target).parents('tr').attr('data-url')
      window.location = url if url
  # new TableView