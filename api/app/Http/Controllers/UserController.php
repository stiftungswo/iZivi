<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
//use Laravel\Lumen\Routing\Controller as BaseController;
use App;
use App\User;
use App\Http\Controllers\Auth\AuthController;
use App\Mission;
use App\Specification;
use Symfony\Component\Console\Output\ConsoleOutput;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class UserController extends Controller
{
    /**
     * Get authenticated user.
     *
     * @return \Illuminate\Http\Response
     */
    public function getZivis()
    {

        //$zivis = DB::table('users')->where('zdp', '>', 0)->get();
        $zivis = DB::table('missions')
            ->join('users', 'missions.user', '=', 'users.id')
            ->join('specifications', 'missions.specification', '=', 'specifications.id')
            ->join('roles', 'roles.id', '=', 'users.role')
            ->whereNull('users.deleted_at')
            ->select('users.id', 'users.zdp', 'users.first_name', 'users.last_name', 'missions.start', 'missions.end', 'users.work_experience', 'specifications.active', 'roles.name AS role', 'roles.id AS role_id')
            ->get();

        /*
        $zivis = DB::table('missions')->get();
        $zivis = DB::table('specifications')->get();
        */

        return new JsonResponse($zivis);
    }

    public function changePassword(Request $request)
    {

        /*$output = new ConsoleOutput();
        $output->writeln("some log to console");*/

        $errors = array();

        $user = JWTAuth::parseToken()->authenticate();

        $pw_old = $request->input("old_password");
        $pw_new = $request->input("new_password");
        $pw_new_2 = $request->input("new_password_2");

        if (empty($pw_old)) {
            $errors['Altes Passwort'] = 'Passwort darf nicht leer sein!';
        }

        if (!$this->isPasswordCorrect($user['email'], $pw_old)) {
            $errors['Altes Passwort'] = 'Altes Passwort stimmt nicht!';
        }

        if ($pw_new != $pw_new_2) {
            $errors['Neues Passwort'] = 'Die neuen Passwörter stimmen nicht überein!';
        }

        if (strlen($pw_new) < AuthController::PW_MIN_LENGTH) {
            $errors['Neues Passwort'] = AuthController::PW_LENGTH_TEXT;
        }

        if (count($errors)>0) {
            return new JsonResponse($errors, Response::HTTP_NOT_ACCEPTABLE);
        }

        $user->password = password_hash($pw_new, PASSWORD_BCRYPT);
        $user->save();

        return new JsonResponse("Ihr Passwort wurde angepasst.");
    }

    private function isPasswordCorrect($email, $password)
    {

        $credentials = array (
            'email' => $email,
            'password' => $password,
        );

        return (JWTAuth::attempt(
            $credentials,
            ['isAdmin' => false]
        ));
    }
}
