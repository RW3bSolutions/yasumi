<?php

namespace App\Http\Controllers\Api\Branch;

use App\Models\Payroll;
use App\Models\PayPeriod;
use App\Models\Therapist;
use App\Models\Commission;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class PayPeriodController extends Controller
{
    public function index (Request $request)
    {
        return PayPeriod::where('branch_id', auth()->user()->branchAccess->branch->id)
        ->withCount([
            'payouts AS total_payouts' => function ($query) {
                    $query->select(DB::raw("SUM(net_pay) as total_net_pay"));
                }
            ])
        ->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'date_from' => 'required|date',
            'date_to' => 'required|date',
            'employees' => 'required|array'
        ]);

        $request->request->add([
            'branch_id' => auth()->user()->branchAccess->branch->id
        ]);

        $diff = strtotime($request->date_to) - strtotime($request->date_from);
        $days = floor($diff / (60 * 60 * 24));

        $payPeriod = PayPeriod::create($request->all());

        foreach ($request->employees as $key => $value) {
            Payroll::create([
                'pay_period_id' => $payPeriod->id,
                'employee_type' => 'Employee',
                'employee_id' => $value['id'],
                'absent' => $value['absent'],
                'net_pay' => $value['rate'] * $days,
            ]);
        }

        foreach (Therapist::where('is_active', 1)->get() as $therapist) {
            $commissions = Commission::whereHas('booking', function ($q) use ($request) {
                $q->where('date', '>=', $request->date_from)->where('date', '<=', $request->date_to);
            })
            ->where('therapist_id', $therapist->id)
            ->sum('commission');

            if ($commissions != 0) {
                Payroll::create([
                    'pay_period_id' => $payPeriod->id,
                    'employee_type' => 'Employee',
                    'therapist_id' => $therapist->id,
                    'absent' => 0,
                    'net_pay' => $commissions,
                ]);
            }
        }

        return 1;

    }

    public function show (Request $request, $id)
    {
        return Payroll::with('therapist', 'employee')->where('pay_period_id', $id)->get();
    }

}
