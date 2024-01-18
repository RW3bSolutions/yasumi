<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    public function index (Request $request)
    {
        return Customer::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'email' => 'required|unique:customers,email',
            'name' => 'required|unique:customers,name',
            'contact_no' => 'required'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Customer::create($request->all());;
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'email' => 'required|unique:customers,email,' . $id,
            'name' => 'required|unique:customers,name,' . $id,
            'contact_no' => 'required'
        ]);

        Customer::find($id)->update($request->all());

        return 1;
    }

    public function show (Request $request, $id)
    {
        $customer = Customer::where('branch_id', auth()->user()->branchAccess->branch->id)->where('name', 'like', '%' . $id . '%')->get();

        if (count($customer) == 0) {
            return response()->json([
                'errors' => [
                    'customer' => ['No Data found!']
                ]
            ], 422);
        }

        return $customer;

    }

    public function destroy (Request $request, $id)
    {
        Customer::find($id)->delete();
        return 1;
    }
}
