<?php

class FreqDiff extends Eloquent {
	protected $table      = 'freq_diff';
	protected $primaryKey = 'entity_id';
	public    $timestamps = false; 
}