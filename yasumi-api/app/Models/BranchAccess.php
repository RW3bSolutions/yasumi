<?php

namespace App\Models;

use App\Models\User;
use App\Models\Branch;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BranchAccess extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'branch_id',
    ];

    protected $hidden = [
        'branch_id',
        'updated_at',
        'created_at'
    ];

    protected $with = [
        'branch',
    ];

    public function user ()
    {
        return $this->belongsTo(User::class);
    }

    public function branch ()
    {
        return $this->belongsTo(Branch::class);
    }

}
