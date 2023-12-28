<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Service extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'name',
        'amount',
        'add_on',
        'duo',
        'is_active'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'name',
            'amount',
            'duo',
            'add_on',
            'is_active'
        ])
        ->useLogName('Service')
        ->logOnlyDirty();
    }

}
