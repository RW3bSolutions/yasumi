<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Service;
use Illuminate\Http\Request;

class ServiceController extends Controller
{
    public function index (Request $request)
    {
        if ($request->active) {
            return Service::where('is_active', 1)->where('branch_id', auth()->user()->branchAccess->branch->id)->get();
        }
        return Service::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:services,name',
            'amount' => 'required|numeric'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Service::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:services,name,' . $id,
            'amount' => 'required|numeric'
        ]);

        Service::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Service::find($id)->delete();
        return 1;
    }
}
