<?php

namespace App\Http\Controllers\Api\Branch;

use App\Models\Expense;
use Illuminate\Http\Request;
use App\Models\ExpenseCategory;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class ExpenseController extends Controller
{

    public function index (Request $request)
    {
        if ($request->branch_id) {
            return Expense::where('branch_id', $request->branch_id)->get();
        }

        if ($request->dashboard) {
            return ExpenseCategory::withCount([
                'expenses as total_expenses' => function ($q) {
                    $q->select(DB::raw("SUM(amount) as total_sum"));
                }
            ])->get();
        }

        return Expense::where('branch_id', auth()->user()->branchAccess->branch->id)->get();
    }

    public function create (Request $request)
    {
        return ExpenseCategory::orderBy('name', 'ASC')->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'date' => 'required|date',
            'particulars' => 'required',
            'payee' => 'required',
            'amount' => 'required|numeric',
            'expense_category' => 'required'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        return Expense::create($request->all());

    }

    public function update (Request $request, $id)
    {
        $request->validate([
            'date' => 'required|date',
            'particulars' => 'required',
            'payee' => 'required',
            'amount' => 'required|numeric',
            'expense_category' => 'required'
        ]);

        return Expense::find($id)->update($request->all());
    }


}
