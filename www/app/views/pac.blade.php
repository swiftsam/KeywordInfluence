<?php //print_r($pac->freqdiff->json_data); ?>

@extends('layout')

@section('content')
	<ol class="breadcrumb">
	  <li><a href='/pac'>PACs</a>  <span class="divider">|</span></li>
	  <li><small>(Industry)</small> <a href='/industry/{{$pac->prim_code}}'>{{$pac->Industry->catname}}</a>  <span class="divider">|</span></li>
	  <li class="active">{{ $pac->pac_short }}</li>
	</ol>
	
	<h2>{{ $pac->pac_short }}</h2>

	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist" id="pacTabs">
	  <li class="active"><a href="#words" role="tab" data-toggle="tab">Words Used</a></li>
	  <li><a href="#contributions" role="tab" data-toggle="tab">Contributions</a></li>
	</ul>

	<!-- Tab panes -->
	<div class="tab-content">
	  <div class="tab-pane active" id="words">
	  	Congresspeople who received contributions from {{$pac->pac_short}} used the following phrases more frequently than the average member of congress.
	  	<ul>
  		<?php
			/*$pac_data = json_decode($pac->freqdiff->json_data, true);
			if(isset($pac_data))
				foreach($pac_data['ngram'] as $ngram)
					echo "<li>".$ngram."</li>";
			else
				echo "no word use data";*/
		?>
		</ul>
		<div id="chart1">
		  <svg></svg>
		</div>

	  </div>
	  <div class="tab-pane" id="contributions">
			<table class="table table-hover table-condensed">
				<tr><th>Date</th><th>Amount</th><th>Congressperson</th></tr>
		    	@foreach($pac->contributions as $contrib)
		        <tr>
		        	<td>{{$contrib->date}}</td>
		        	<td>{{$contrib->amount}}</td>

		        	<td><?php 
		        		$cp = $contrib->congressperson;
		        		if(isset($cp)){
		        			echo("(".$cp->party."-".$cp->state.") ".$cp->firstname." ".$cp->lastname);
			        	} else {
			        		echo("<i>not elected</i>");
			        	}
		        		?>
					</td>
		       	</tr>
		    	@endforeach
			</table>	  	
	  </div>
	</div>

	<style>

#chart1 {
  margin: 10px;
  min-width: 100px;
  min-height: 100px;
/*
  Minimum height and width is a good idea to prevent negative SVG dimensions...
  For example width should be =< margin.left + margin.right + 1,
  of course 1 pixel for the entire chart would not be very useful, BUT should not have errors
*/
}

#chart1 svg {
  height: 400px;
  width: 700px;
}

</style>

	<script type="text/javascript">

pac_data = [
	{   
		key: 'Series1',
	    color: '#d62728',
	    values: {{ $pac->freqdiff->json_data }}
	}
];

		// content tabs
		$(function () {
		$('#pacTabs a:last').tab('show')
		});

		var chart;
		nv.addGraph(function() {
		  chart = nv.models.multiBarHorizontalChart()
		      .x(function(d) { return d.ngram })
		      .y(function(d) { return d.freq_diff })
		      .margin({top: 30, right: 20, bottom: 50, left: 175})
		      .showValues(true)
		      .tooltips(false)
		      .barColor(d3.scale.category20().range())
		      .transitionDuration(250)
		      .stacked(true)
		      .showControls(false);

		  chart.yAxis
		      .tickFormat(d3.format(',.4f'));

		  d3.select('#chart1 svg')
		      .datum(pac_data)
		      //.datum(long_short_data)
		      .call(chart);

		  nv.utils.windowResize(chart.update);

		  chart.dispatch.on('stateChange', function(e) { nv.log('New State:', JSON.stringify(e)); });

		  return chart;
		});

	</script>
@stop
