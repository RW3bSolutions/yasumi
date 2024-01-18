<?php

namespace App\Http\Controllers\Api\Branch;

use App\Models\Sale;
use App\Models\Booking;
use App\Models\Service;
use App\Models\Voucher;
use App\Models\Customer;
use App\Models\Therapist;
use App\Models\Commission;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class BookingController extends Controller
{

    public function index (Request $request)
    {
        if ($request->date && $request->schedules) {
            return Booking::with('sales', 'customer:id,name,contact_no')->where('date', $request->date)->where('branch_id', auth()->user()->branchAccess->branch->id)->orderBy('time', 'ASC')->get();
        }

        return Booking::where('branch_id', auth()->user()->branchAccess->branch->id)->orderBy('date', 'DESC')->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'date' => 'required|date',
            'room_id' => 'required|exists:rooms,id',
            'time' => 'required|date_format:H:i',
            'customer' => 'required|exists:customers,id',
            'dp' => 'nullable|numeric',
            'service_orders' => 'required|array'
        ]);

        $total = 0;

        $customer = Customer::find($request->customer);

        $request->request->add([
            'customer_id' => $request->customer,
            'name' => $customer->name,
            'contact_no' => $customer->contact_no,
            'branch_id' => auth()->user()->branchAccess->branch->id,
            'total_amount' => 0
        ]);

        $booking = Booking::create($request->all());

        foreach ($request->service_orders as $key => $value) {
            $service = Service::where('name', $value['service'])->first();
            Sale::create([
                'branch_id' => auth()->user()->branchAccess->branch->id,
                'booking_id' => $booking->id,
                'service_id' => $service->id,
                'service' => $value['service'],
                'amount' => $value['amount'],
                'add_on' => $value['add_on'],
                'therapists' => json_encode($value['therapists']),
                'duo' => $value['duo'],
            ]);

            $total += $value['amount'];
        }

        $booking->update([
            'total_amount' => $total
        ]);

        return 1;
    }

    public function update (Request $request, $id)
    {
        $booking = Booking::find($id);
        if ($request->action == 'ChangeStatus') {
            if ($request->status == 'Completed') {
                $request->validate([
                    'fp' => 'required|numeric',
                    'fp_payment_method' => 'required'
                ]);

                $booking->update([
                    'status' => $request->status,
                    'fp' => $request->fp,
                    'fp_payment_method' => $request->fp_payment_method,
                ]);
            }
            if ($request->status == 'Cancelled') {
                $booking->update([
                    'status' => $request->status,
                    'fp' => 0,
                    'fp_payment_method' => null,
                ]);
            }
            if ($request->status == 'Reschedule') {
                $request->validate([
                    'reschedule_date' => 'required|date'
                ]);

                $booking->update([
                    'status' => $request->status,
                    'date' => $request->reschedule_date,
                ]);
            }

            if ($request->status == 'Voucher') {
                $request->validate([
                    'code' => 'required|exists:vouchers,code'
                ]);

                $voucher = Voucher::where('code', $request->code)->first();

                if ($voucher->booking_id) {
                    return response()->json([
                        'errors' => [
                            'code' => ['The code is already taken.']
                        ]
                    ] ,422);
                }

                $voucher->update([
                    'booking_id' => $booking->id,
                    'date_used' => $booking->date
                ]);

                $booking->update([
                    'status' => 'Completed',
                    'fp_payment_method' => 'Voucher',
                    'fp' => $voucher->amount
                ]);
            }

            if ($request->status == 'Completed' || $request->status == 'Voucher') {
                foreach (Sale::where('booking_id', $id)->where('add_on', 0)->get() as $key => $value) {

                    if ($value->duo) {
                        Commission::create([
                            'branch_id' => auth()->user()->branchAccess->branch->id,
                            'booking_id' => $id,
                            'sale_id' => $value->id,
                            'therapist_id' => json_decode($value->therapists)[0],
                            'service' => $value->service,
                            'amount' => $value->amount / 2,
                            'commission' => ($value->amount / 2) * (Therapist::find(json_decode($value->therapists)[0])->commission / 100),
                        ]);
                        Commission::create([
                            'branch_id' => auth()->user()->branchAccess->branch->id,
                            'booking_id' => $id,
                            'sale_id' => $value->id,
                            'therapist_id' => json_decode($value->therapists)[1],
                            'service' => $value->service,
                            'amount' => $value->amount / 2,
                            'commission' => ($value->amount / 2) * (Therapist::find(json_decode($value->therapists)[1])->commission / 100),
                        ]);
                    } else {
                        Commission::create([
                            'branch_id' => auth()->user()->branchAccess->branch->id,
                            'booking_id' => $id,
                            'sale_id' => $value->id,
                            'therapist_id' => json_decode($value->therapists)[0],
                            'service' => $value->service,
                            'amount' => $value->amount,
                            'commission' => $value->amount * (Therapist::find(json_decode($value->therapists)[0])->commission / 100),
                        ]);
                    }
                }
            }

            return 1;
        }

        return 1;
    }

}
