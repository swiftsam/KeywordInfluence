<?php 
	$industry_consolidated = array();
	foreach($industry->pacs as $pac){
		if(array_key_exists($pac->cmte_id,$industry_consolidated)){
			array_push($industry_consolidated[$pac->cmte_id], $pac);
		} else {
			$industry_consolidated[$pac->cmte_id] = array($pac);
		}
	}
	//print_r($industry_consolidated);
?>

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
	<tr><th>PAC name</th><th>Campaign Cycle(s)</th></tr>
    @foreach($industry_consolidated as $pac_id => $value)
        <tr>
        	<td><a href="/pac/{{ $pac_id }}"><?php echo($value[0]->pac_short);?></a></td>
        	<td><?php foreach($value as $pac){ echo($pac->cycle.", ");} ?></td>
       	</tr>
    @endforeach
	</table>

@stop