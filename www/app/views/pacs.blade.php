@extends('layout')
@section('content')
<h2>Influence by PAC</h2>
<div class="pagination"><?php echo $pacs->links(); ?></div>
<table class="table table-hover table-condensed">
	<tr><th>PAC</th><th>Sector : Industry</th></tr>
    @foreach($pacs as $pac)
        <tr>
        	<td><a href="/pac/{{ $pac->cmte_id}}">{{ $pac->pac_short }}</a></td>
        	<td>{{ $pac->Industry->sector }} : {{ $pac->Industry->catname }}</td>
       	</tr>
    @endforeach
</table>
@stop
