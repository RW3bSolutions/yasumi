<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Sale;
use Illuminate\Http\Request;

class SalesController extends Controller
{
    public function index (Request $request)
    {
        if ($request->branch_id) {
            return Sale::with('booking:id,customer_id,date', 'booking.customer:id,name,contact_no')->where('branch_id', $request->branch_id)->whereHas('booking', function ($q){
                $q->where('status', 'Completed');
            })->get();
        }

        return Sale::with('booking:id,customer_id,date', 'booking.customer:id,name,contact_no')->where('branch_id', auth()->user()->branchAccess->branch->id)->whereHas('booking', function ($q){
            $q->where('status', 'Completed');
        })->get();
    }
}
