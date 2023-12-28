<?php

namespace App\Models;

use App\Models\Customer;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Refund extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'customer_id',
        'date',
        'service',
        'pax',
        'amount',
        'payment_method',
        'amount_refund',
        'reason',
        'cancelled',
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
            'customer.contact_no',
            'date',
            'service',
            'pax',
            'amount',
            'payment_method',
            'amount_refund',
            'reason',
            'cancelled',
        ])
        ->useLogName('Refund')
        ->logOnlyDirty();
    }

    public function customer ()
    {
        return $this->belongsTo(Customer::class);
    }

}
