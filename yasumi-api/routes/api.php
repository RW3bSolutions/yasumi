<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin as AdminApi;
use App\Http\Controllers\Api\Branch as BranchApi;
use App\Http\Controllers\Api\Global as GlobalApi;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('global')->group(function (){
    Route::middleware(['auth:sanctum'])->group(function (){
        Route::post('/activity-logs', [GlobalApi\ActivityLogController::class, 'activityLogs']);
    });
});

Route::prefix('admin')->group(function (){
    Route::post('/login', [AdminApi\AuthController::class, 'login']);

    Route::middleware(['auth:sanctum'])->group(function (){
        Route::post('/logout', [AdminApi\AuthController::class, 'logout']);

        Route::resource('branches', AdminApi\BranchController::class);
        Route::resource('branch-users', AdminApi\BranchUserController::class);

        Route::resource('expense-categories', AdminApi\ExpenseCategoryController::class);

        Route::resource('expenses', BranchApi\ExpenseController::class)->only('index','create');
        Route::resource('therapists', BranchApi\TherapistController::class)->only('index');
        Route::resource('sales', BranchApi\SalesController::class)->only('index');
        Route::resource('commissions', BranchApi\CommissionController::class)->only('index');

    });
});

Route::prefix('branch')->group(function (){
    Route::post('/login', [BranchApi\AuthController::class, 'login']);

    Route::middleware(['auth:sanctum'])->group(function (){
        Route::post('/logout', [BranchApi\AuthController::class, 'logout']);

        Route::resource('expenses', BranchApi\ExpenseController::class);
        Route::resource('therapists', BranchApi\TherapistController::class);
        Route::resource('employees', BranchApi\EmployeeController::class);
        Route::resource('rooms', BranchApi\RoomController::class);
        Route::resource('bookings', BranchApi\BookingController::class);
        Route::resource('sales', BranchApi\SalesController::class);
        Route::resource('commissions', BranchApi\CommissionController::class);
        Route::resource('customers', BranchApi\CustomerController::class);
        Route::resource('refunds', BranchApi\RefundController::class);
        Route::resource('vouchers', BranchApi\VoucherController::class);
        Route::resource('pay-periods', BranchApi\PayPeriodController::class);
        Route::resource('services', BranchApi\ServiceController::class);

    });
});

