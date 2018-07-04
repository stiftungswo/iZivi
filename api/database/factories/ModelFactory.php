<?php

use Faker\Generator;
use Illuminate\Database\Eloquent\Factory;

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| Here you may define all of your model factories. Model factories give
| you a convenient way to create models for testing and seeding your
| database. Just tell the factory how a default model should look.
|
*/

/** @var Factory $factory */

$factory->define(App\User::class, function (Generator $faker) {
    return [
        'first_name' => $faker->name,
        'last_name' => $faker->name,
        'email' => $faker->email,
        'password' => app('hash')->make($faker->password),
        'remember_token' => str_random(10),
        'role' => 2,
        'regional_center' => 2,
        'zdp' => $faker->randomNumber(6),
        'address' => $faker->streetAddress,
        'city' => $faker->city,
        'hometown' => $faker->city,
        'zip' => $faker->postcode,
        'birthday' => $faker->date(),
        'phone_mobile' => $faker->phoneNumber,
        'bank_iban' => $faker->iban('CH'),
        'bank_bic' => $faker->swiftBicNumber,
        'health_insurance' => $faker->company,
        'work_experience' => $faker->sentence(),
    ];
});

$factory->defineAs(App\User::class, 'admin', function (Generator $faker) use ($factory) {
    $user = $factory->raw(App\User::class);
    $user['role'] = 1;
    return $user;
});

$factory->define(App\Holiday::class, function (Generator $faker) {
    $from = $faker->dateTimeThisYear;

    return [
        'date_from' => $from->format('Y-m-d'),
        'date_to' => $faker->dateTimeInInterval($from, '+ 3 days'),
        'holiday_type' => function () use ($faker) {
            return App\HolidayType::find($faker->randomElement([1,2,2,2,2,2,2,2,2])); // 1 = Betriebsferien, 2 = Feiertag
        },
        'description' => $faker->word
    ];
});
