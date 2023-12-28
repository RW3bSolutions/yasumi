<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Branch;
use Illuminate\Http\Request;

class BranchController extends Controller
{
    public function index (Request $request)
    {
        return Branch::all();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:branches,name',
            'address' => 'required'
        ]);

        return Branch::create($request->all());
    }

    public function show (Request $request, $id)
    {
        return Branch::find($id);
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:branches,name,' . $id,
            'address' => 'required'
        ]);

        Branch::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Branch::find($id)->delete();
        return 1;
    }
}
