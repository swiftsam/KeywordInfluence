<?php

class PacContribution extends Eloquent {
	protected $table      = 'pac_contrib';
	protected $primaryKey = 'fec_rec_no';
	public    $timestamps    = false; 

	public function congressperson()
    {
        return $this->hasOne('Congressperson', 'bioguide_id', 'candidate_id');
    }
}