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
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('customer_id');
            $table->date('date');
            $table->string('time');
            $table->bigInteger('branch_id');
            $table->bigInteger('room_id');
            $table->string('name');
            $table->string('contact_no');
            $table->double('total_amount');
            $table->double('dp')->default(0);
            $table->string('dp_payment_method')->nullable();
            $table->double('fp')->default(0);
            $table->string('fp_payment_method')->nullable();
            $table->string('status')->default('Pending');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};
