<?php

class Industry extends Eloquent {
	protected $table      = 'industry';
	protected $primaryKey = 'catcode';
	public    $timestamps    = false; 

    public function pacs()
    {
        return $this->hasMany('Pac', 'prim_code', 'catcode');
    }
}
