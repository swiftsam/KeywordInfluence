@extends('layout')

@section('content')

	<ol class="breadcrumb">
	  <li><a href='/pac'>PACs</a>  <span class="divider">|</span></li>
	  <li><small>(Industry)</small> <a href='/industry/{{$pac->prim_code}}'>{{$pac->Industry->catname}}</a>  <span class="divider">|</span></li>
	  <li class="active">{{ $pac->pac_short }}</li>
	</ol>

	<h2>{{ $pac->pac_short }}</h2>

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


@stop
