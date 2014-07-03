@extends('layout')
@section('content')
<div class="pagination"><?php echo $pacs->links(); ?></div>
<table>
    @foreach($pacs as $pac)
        <tr>
        	<td><a href="/pac/{{ $pac->cmte_id}}">{{ $pac->pac_short }}</a></td>
       	</tr>
    @endforeach
</table>
@stop
