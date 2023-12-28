<?php

namespace App\Models;

use App\Models\Employee;
use App\Models\Therapist;
use Spatie\Activitylog\LogOptions;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Payroll extends Model
{
    use HasFactory, LogsActivity;

    protected $fillable = [
        'branch_id',
        'pay_period_id',
        'employee_type',
        'employee_id',
        'therapist_id',
        'absent',
        'net_pay',
    ];

    protected $hidden = [
        'updated_at',
        'created_at'
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
        ->logOnly([
            'pay_period_id',
            'employee_type',
            'absent',
            'net_pay',
        ])
        ->useLogName('Sales')
        ->logOnlyDirty();
    }

    public function employee ()
    {
        return $this->belongsTo(Employee::class);
    }

    public function therapist ()
    {
        return $this->belongsTo(Therapist::class);
    }

}
