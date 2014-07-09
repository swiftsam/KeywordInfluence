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
	  		<?php
				$diff_data = json_decode($pac->freqdiff->json_data, true);
				if(isset($diff_data))
					foreach($diff_data['ngram'] as $ngram)
						echo $ngram . "</br>";
				else
					echo "no word use data";
			?>
			<div id="chart">
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

	<script type="text/javascript">
	  // content tabs
	  $(function () {
	    $('#pacTabs a:last').tab('show')
	  })

	  nv.addGraph(function() {
	  var chart = nv.models.multiBarHorizontalChart()
	      .x(function(d) { return d.label })
	      .y(function(d) { return d.value })
	      .margin({top: 30, right: 20, bottom: 50, left: 175})
	      .showValues(true)
	      .tooltips(false)
	      .showControls(false);

	  chart.yAxis
	      .tickFormat(d3.format(',.2f'));

	  d3.select('#chart svg')
	      .datum(<?php echo($pac->freqdiff->json_data); ?>)
	    .transition().duration(500)
	      .call(chart);

	  //nv.utils.windowResize(chart.update);

	  return chart;
	});
	</script>
@stop
