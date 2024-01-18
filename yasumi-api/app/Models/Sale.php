<?php

namespace App\Models;

use App\Models\Branch;
use App\Models\Booking;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Sale extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'booking_id',
        'service_id',
        'service',
        'amount',
        'add_on',
        'duo',
        'therapists',
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'branch_id',
            'booking_id',
            'service_id',
            'service',
            'amount',
            'add_on',
            'duo',
            'therapists',
        ])
        ->useLogName('Sales')
        ->logOnlyDirty();
    }

    public function booking ()
    {
        return $this->belongsTo(Booking::class);
    }

}
