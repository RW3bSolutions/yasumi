<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Branch extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'name',
        'address',
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
            'address',
            'is_active'
        ])
        ->useLogName('Branch')
        ->logOnlyDirty();
    }

}
