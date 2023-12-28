<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    public function index (Request $request)
    {
        if ($request->active) {
            return Room::where('is_active', 1)->where('branch_id', auth()->user()->branchAccess->branch->id)->get();
        }

        return Room::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:rooms,name',
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Room::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:rooms,name,' . $id,
        ]);

        Room::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        Room::find($id)->delete();
        return 1;
    }
}
