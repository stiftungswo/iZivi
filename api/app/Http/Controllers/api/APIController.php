<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Laravel\Lumen\Application;
use Illuminate\Http\JsonResponse;

class APIController extends Controller
{

    /**
     * Get root url.
     *
     * @param Application $app
     *
     * @return JsonResponse
     */
    public function getIndex(Application $app)
    {
        return new JsonResponse(['message' => $app->version()]);
    }
}
