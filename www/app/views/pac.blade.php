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
	  </div>
	  <div class="tab-pane" id="contributions">
			<table class="table table-hover table-condensed">
				<tr><th>Date</th><th>Amount</th><th>Candidate</th></tr>
		    @foreach($pac->contributions as $contrib)
		        <tr>
		        	<td>{{$contrib->date}}</td>
		        	<td>{{$contrib->amount}}</td>
		        	<td>{{$contrib->candidate_id}}</td>
		       	</tr>
		    @endforeach
			</table>	  	
	  </div>
	</div>



	<script>
	  $(function () {
	    $('#pacTabs a:last').tab('show')
	  })
	</script>
@stop
