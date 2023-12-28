<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('payrolls', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('pay_period_id');
            $table->string('employee_type');
            $table->bigInteger('employee_id')->nullable();
            $table->bigInteger('therapist_id')->nullable();
            $table->double('absent')->default(0);
            $table->double('net_pay');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payrolls');
    }
};
