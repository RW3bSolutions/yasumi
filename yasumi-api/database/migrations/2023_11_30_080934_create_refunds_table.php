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
        Schema::create('refunds', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('branch_id')->nullable();
            $table->bigInteger('customer_id')->nullable();
            $table->date('date');
            $table->string('service');
            $table->string('pax');
            $table->double('amount');
            $table->string('payment_method');
            $table->double('amount_refund');
            $table->longText('reason');
            $table->boolean('cancelled')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('refunds');
    }
};
