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
            'name' => 'required|unique:customers,name',
            'contact_no' => 'required'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        Customer::create($request->all());

        return 1;
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:customers,name,' . $id,
            'contact_no' => 'required'
        ]);

        Customer::find($id)->update($request->all());

        return 1;
    }

    public function show (Request $request, $id)
    {
        return Customer::where('branch_id', auth()->user()->branchAccess->branch->id)->where('name', 'like', '%' . $id . '%')->get();
    }

    public function destroy (Request $request, $id)
    {
        Customer::find($id)->delete();
        return 1;
    }
}
