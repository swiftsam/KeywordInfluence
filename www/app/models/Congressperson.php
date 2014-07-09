<?php

class Congressperson extends Eloquent {
	protected $table      = 'congress';
	protected $primaryKey = 'bioguide_id';
	public    $timestamps = false;
}
