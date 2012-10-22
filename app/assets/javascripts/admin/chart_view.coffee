AmCharts.ready ->
	class ChartView extends Backbone.View
		el: $ '#chart'
		
		initialize: ->
			@chart = new AmCharts.AmPieChart()
			@chart.dataProvider = chartData
			@chart.titleField = "status"
			@chart.valueField = "total"
			@chart.sequencedAnimation = true
			@chart.startEffect = "elastic"
			@chart.innerRadius = "30%"
			@chart.labelRadius = 15
			@chart.depth3D = 10
			@chart.angle = 15
			@chart.write(@el)
	new ChartView