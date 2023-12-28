<?php

namespace App\Models;

use App\Models\Room;
use App\Models\Sale;
use App\Models\Customer;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Booking extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'customer_id',
        'date',
        'time',
        'branch_id',
        'room_id',
        'total_amount',
        'dp',
        'dp_payment_method',
        'fp',
        'fp_payment_method',
        'status'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'customer.name',
            'date',
            'time',
            'room.name',
            'total_amount',
            'dp',
            'dp_payment_method',
            'fp',
            'fp_payment_method',
            'status'
        ])
        ->useLogName('Booking')
        ->logOnlyDirty();
    }

    public function customer ()
    {
        return $this->belongsTo(Customer::class);
    }

    public function room ()
    {
        return $this->belongsTo(Room::class);
    }

    public function sales ()
    {
        return $this->hasMany(Sale::class);
    }

}
