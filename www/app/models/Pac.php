<?php

class Pac extends Eloquent {
	protected $table      = 'pac';
	protected $primaryKey = 'cmte_id';
	public    $timestamps    = false; 

	public function industry()
    {
        return $this->hasOne('Industry', 'catcode', 'prim_code');
    }
    
    public function freqdiff()
    {
        return $this->hasOne('FreqDiff','entity_id');
    }

    public function contributions()
    {
    	return $this->hasMany('PacContribution', 'pac_id');
    }

    public function congresspersons()
    {
        return $this->hasManyThrough('Post', 'User', 'country_id', 'user_id');
    }
}



