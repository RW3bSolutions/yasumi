<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\ExpenseCategory;
use Illuminate\Http\Request;

class ExpenseCategoryController extends Controller
{

    public function index (Request $request)
    {
        return ExpenseCategory::all();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required|unique:expense_categories,name'
        ]);

        return ExpenseCategory::create($request->all());
    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required|unique:expense_categories,name,' . $id
        ]);

        ExpenseCategory::find($id)->update($request->all());

        return 1;
    }

    public function destroy (Request $request, $id)
    {
        ExpenseCategory::find($id)->delete();
        return 1;
    }

}
