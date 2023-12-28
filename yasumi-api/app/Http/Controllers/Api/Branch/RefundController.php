<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Refund;
use Illuminate\Http\Request;

class RefundController extends Controller
{
    public function index (Request $request)
    {
        if ($request->branch_id) {
            return Refund::with('customer:id,name,contact_no')->where('branch_id', $request->branch_id)->get();
        }

        return Refund::with('customer:id,name,contact_no')->where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'customer' => 'required|exists:customers,id',
            'date' => 'required|date',
            'service' => 'required',
            'pax' => 'required|numeric',
            'amount' => 'required|numeric',
            'payment_method' => 'required',
            'amount_refund' => 'required|numeric',
            'reason' => 'required',
        ]);

        $request->request->add([
            'customer_id' => $request->customer,
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Refund::create($request->all());

    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'customer' => 'required|exists:customers,id',
            'date' => 'required|date',
            'service' => 'required',
            'pax' => 'required|numeric',
            'amount' => 'required|numeric',
            'payment_method' => 'required',
            'amount_refund' => 'required|numeric',
            'reason' => 'required',
        ]);

        $request->request->add([
            'customer_id' => $request->customer,
        ]);

        return Refund::find($id)->update($request->all());
    }

}
