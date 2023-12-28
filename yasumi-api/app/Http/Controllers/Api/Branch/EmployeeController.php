<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Employee;
use Illuminate\Http\Request;

class EmployeeController extends Controller
{
    public function index (Request $request)
    {
        if ($request->branch_id) {
            return Employee::where('branch_id', $request->branch_id)->get();
        }

        if ($request->active) {
            return Employee::where('is_active', 1)->where('branch_id', auth()->user()->branchAccess->branch->id)->get();
        }
        return Employee::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:employees,name',
            'rate' => 'required|numeric'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Employee::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:employees,name,' . $id,
            'rate' => 'required|numeric'
        ]);

        Employee::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Employee::find($id)->delete();
        return 1;
    }
}
