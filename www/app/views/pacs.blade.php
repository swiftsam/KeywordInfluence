@extends('layout')
@section('content')
<h2>Influence by PAC</h2>
<div class="pagination"><?php echo $pacs->links(); ?></div>
<table class="table">
    @foreach($pacs as $pac)
        <tr>
        	<td><a href="/pac/{{ $pac->cmte_id}}">{{ $pac->pac_short }}</a></td>
       	</tr>
    @endforeach
</table>
@stop
