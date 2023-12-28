<?php

namespace App\Http\Controllers\Api\Branch;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Illuminate\Http\Request;

use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|exists:users,username',
            'password' => 'required',
        ]);

        $user = User::where('username', $request->username)->where('portal', 'Branch')->where('is_active', 1)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'invalid' => ['The provided credentials are incorrect.'],
            ]);
        }

        return $user->createToken('Admin')->plainTextToken;
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return 1;
    }
}
