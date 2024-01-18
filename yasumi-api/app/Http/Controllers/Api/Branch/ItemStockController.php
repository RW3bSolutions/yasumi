<?php

namespace App\Http\Controllers\Api\Branch;

use App\Models\Item;
use App\Models\ItemStock;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ItemStockController extends Controller
{
    public function index (Request $request)
    {
        return ItemStock::where('item_id', $request->item_id)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'description' => 'required',
            'qty' => 'required|integer',
            'item_id' => 'required|exists:items,id'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        $item = Item::find($request->item_id);
        if ($request->event == 'Stock-In') {
            $item->stock = $item->stock + $request->qty;
        }
        if ($request->event == 'Stock-Out') {
            $item->stock = $item->stock - $request->qty;
        }
        $item->save();

        return ItemStock::create($request->all());

    }

}
