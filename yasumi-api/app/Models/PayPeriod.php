<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PayPeriod extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'date_from',
        'date_to',
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'date_from',
            'date_to',
        ])
        ->useLogName('PayPeriod')
        ->logOnlyDirty();
    }

    public function payouts ()
    {
        return $this->hasMany(Payroll::class);
    }

}
