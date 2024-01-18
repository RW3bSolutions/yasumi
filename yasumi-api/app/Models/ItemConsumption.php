<?php

namespace App\Models;

use App\Models\Item;
use App\Models\Service;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ItemConsumption extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'service_id',
        'item_id',
        'qty'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'service.name',
            'service.unit',
            'item.name',
            'qty'
        ])
        ->useLogName('Item Consumption')
        ->logOnlyDirty();
    }

    public function service ()
    {
        return $this->belongsTo(Service::class);
    }

    public function item ()
    {
        return $this->belongsTo(Item::class);
    }
}
