@extends('layout')
@section('content')
<h2>Influence by Industry</h2>
<div class="pagination"><?php echo $industries->links(); ?></div>
<table class="table">
    @foreach($industries as $industry)
        <tr>
        	<td><a href="/industry/{{ $industry->catcode}}">{{ $industry->catname }}</a></td>
       	</tr>
    @endforeach
</table>
@stop