
@extends('layout')

@section('content')
<?php echo $pacs->links(); ?>
<table>
    @foreach($pacs as $pac)
        <tr>
        	<td><a href="/pac/{{ $pac->cmte_id}}">{{ $pac->pac_short }}</a></td>
       	</tr>
    @endforeach
</table>

@stop
