<?php

namespace App\Http\Controllers\Api\Branch;

use App\Models\Item;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ItemController extends Controller
{
    public function index (Request $request)
    {
        if ($request->active) {
            return Item::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
        }

        return Item::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:items,name',
            'unit' => 'required'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Item::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:items,name,' . $id,
            'unit' => 'required'
        ]);

        Item::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Item::find($id)->delete();
        return 1;
    }
}
