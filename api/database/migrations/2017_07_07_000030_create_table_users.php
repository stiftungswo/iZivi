<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTableUsers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->timestamps();
            $table->softDeletes();
            $table->rememberToken();
            $table->string('email')->unique()->nullable(false);
            $table->string('password', 60)->nullable(false);
            $table->string('zdp')->nullable(false);  // ZivilDienstPlatz, Nummer des Zivildienstleistenden
            $table->string('first_name')->nullable(false);
            $table->string('last_name')->nullable(false);
            $table->string('address');
            $table->string('city');
            $table->string('hometown');
            $table->integer('hometown_canton')->unsigned()->nullable();
            $table->foreign('hometown_canton')->references('id')->on('cantons');
            $table->integer('canton')->unsigned()->nullable();
            $table->foreign('canton')->references('id')->on('cantons');
            $table->date('birthday')->nullable(false);
            $table->string('phone_mobile');
            $table->string('phone_private');
            $table->string('phone_business');
            $table->string('bank_iban');
            $table->string('post_account');
            $table->text('work_experience')->nullable();
            $table->boolean('driving_licence')->nullable();
            $table->string('travel_card')->nullable();
            $table->integer('regional_center')->unsigned();
            $table->foreign('regional_center')->references('id')->on('regional_centers');
            $table->text('internal_note');
        });
    }
    
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('users');
    }
}
