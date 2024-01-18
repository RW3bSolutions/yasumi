<?php

namespace App\Models;

use App\Models\Item;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ItemStock extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'item_id',
        'event',
        'description',
        'qty'
    ];

    protected $hidden = [
        'updated_at',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'item.name',
            'description',
            'event',
            'qty'
        ])
        ->useLogName('Branch')
        ->logOnlyDirty();
    }

    public function item ()
    {
        return $this->belongsTo(Item::class);
    }

}
