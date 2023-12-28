<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ExpenseCategory extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'name',
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
            'is_active'
        ])
        ->useLogName('Expense Category')
        ->logOnlyDirty();
    }

}
