<?php

namespace App\Http\Controllers\Api\Branch;

use App\Models\Voucher;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class VoucherController extends Controller
{
    public function index (Request $request)
    {
        if ($request->branch_id) {
            return Voucher::with('booking:id,customer_id,date', 'booking.customer:id,name,contact_no')->where('branch_id', $request->branch_id)->get();
        }

        return Voucher::with('booking:id,customer_id,date', 'booking.customer:id,name,contact_no')->where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric'
        ]);

        $request->request->add([
            'code' => Str::random(10),
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Voucher::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'amount' => 'required|numeric'
        ]);

        Voucher::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Voucher::find($id)->delete();
        return 1;
    }
}
