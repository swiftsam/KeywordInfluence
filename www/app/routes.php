<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/

Route::get('/', function()
{
	return 'Main Page';
});

Route::get('pac', function()
{
    $pacs = Pac::paginate(15);
    return View::make('pacs')->with('pacs', $pacs);
});

Route::get('pac/{id}', function($id)
{
	$pac = Pac::find($id);
	return View::make('pac')->with('pac', $pac);
});

Route::get('foundation', function()
{
    return View::make('foundation');
});