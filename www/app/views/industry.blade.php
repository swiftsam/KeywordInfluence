@extends('layout')

@section('content')
	<ol class="breadcrumb">
	  <li><a href='/industry'>Industries</a>  <span class="divider">|</span></li>
	  <li><small>(Sector)</small> {{ $industry->sector}}  <span class="divider">|</span></li>
	  <li><small>(Category)</small> {{ $industry->industry}}  <span class="divider">|</span></li>
	  <li class="active">{{ $industry->catname }}</li>
	</ol>

	<h2>{{ $industry->catname }}</h2>

@stop