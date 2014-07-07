@extends('layout')

@section('content')
	<ol class="breadcrumb">
	  <li><a href='/industry'>Industries</a>  <span class="divider">|</span></li>
	  <li><small>(Sector)</small> {{ $industry->sector}}  <span class="divider">|</span></li>
	  <li><small>(Category)</small> {{ $industry->industry}}  <span class="divider">|</span></li>
	  <li class="active">{{ $industry->catname }}</li>
	</ol>

	<h2>{{ $industry->catname }}</h2>

	<table class="table table-hover table-condensed">
	<tr><th>PAC name</th><th>Campaign Cycle</th></tr>
    @foreach($industry->pacs as $pac)
        <tr>
        	<td><a href="/pac/{{ $pac->cmte_id}}">{{ $pac->pac_short }}</a></td>
        	<td>{{$pac->cycle}}</td>
       	</tr>
    @endforeach
	</table>

@stop