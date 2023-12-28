<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Voucher extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'booking_id',
        'code',
        'amount',
        'date_used',

    ];

    protected $hidden = [
        'updated_at',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'code',
            'amount',
            'date_used',
        ])
        ->useLogName('Voucher')
        ->logOnlyDirty();
    }

    public function booking ()
    {
        return $this->belongsTo(Booking::class);
    }

}
