<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Commission;
use Illuminate\Http\Request;

class CommissionController extends Controller
{
    public function index (Request $request)
    {
        if ($request->therapist_id) {
            return Commission::with('booking:id,name,contact_no,date')->where('therapist_id', $request->therapist_id)->whereHas('booking', function ($q){
                $q->where('status', 'Completed');
            })->get();
        }
        if ($request->branch_id) {
            return Commission::with('booking:id,name,contact_no,date')->where('branch_id', $request->branch_id)->whereHas('booking', function ($q){
                $q->where('status', 'Completed');
            })->get();
        }
    }
}
