<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use App\Models\ItemConsumption;
use Illuminate\Http\Request;

class ItemConsumptionController extends Controller
{
    public function index (Request $request)
    {
        return ItemConsumption::where('service_id', $request->service_id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'item_id' => 'required|exists:items,id',
            'qty' => 'required|integer'
        ]);

        return ItemConsumption::create($request->all());
    }

    public function destroy (Request $request, $id)
    {
        ItemConsumption::find($id)->delete();
        return 1;
    }

}
