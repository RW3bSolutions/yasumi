<?php

namespace App\Models;

use App\Models\Booking;
use App\Models\Therapist;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Commission extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'booking_id',
        'sale_id',
        'therapist_id',
        'service',
        'amount',
        'commission',
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'therapist.name',
            'service',
            'amount',
            'commission',
        ])
        ->useLogName('Commission')
        ->logOnlyDirty();
    }

    public function therapist ()
    {
        return $this->belongsTo(Therapist::class);
    }

    public function booking ()
    {
        return $this->belongsTo(Booking::class);
    }

}
