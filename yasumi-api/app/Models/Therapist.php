<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Therapist extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'name',
        'commission',
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
            'commission',
            'is_active'
        ])
        ->useLogName('Therapist')
        ->logOnlyDirty();
    }
}
