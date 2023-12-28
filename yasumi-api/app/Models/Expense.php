<?php

namespace App\Models;

use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Expense extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'date',
        'particulars',
        'payee',
        'amount',
        'expense_category',
        'petty_cash',
        'cancelled'
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'date',
            'particulars',
            'payee',
            'amount',
            'expense_category',
            'petty_cash',
            'cancelled',
        ])
        ->useLogName('Expense')
        ->logOnlyDirty();
    }

}
