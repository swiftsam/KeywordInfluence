<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
*/

Route::get('/', function()
{
	return View::make('main');
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

Route::get('industry', function()
{
    $industries = Industry::paginate(15);
    return View::make('industries')->with('industries', $industries);
});

Route::get('industry/{id}', function($id)
{
	$industry = Industry::find($id);
	return View::make('industry')->with('industry', $industry);
});

Route::get('about', function()
{
	return View::make('about');
});

