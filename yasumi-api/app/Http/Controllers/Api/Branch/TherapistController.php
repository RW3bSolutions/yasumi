<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Therapist;
use Illuminate\Http\Request;

class TherapistController extends Controller
{
    public function index (Request $request)
    {
        if ($request->branch_id) {
            return Therapist::where('branch_id', $request->branch_id)->get();
        }

        if ($request->active) {
            return Therapist::where('is_active', 1)->where('branch_id', auth()->user()->branchAccess->branch->id)->get();
        }
        return Therapist::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:therapists,name',
            'commission' => 'required|numeric'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Therapist::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:therapists,name,' . $id,
            'commission' => 'required|numeric'
        ]);

        Therapist::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Therapist::find($id)->delete();
        return 1;
    }
}
