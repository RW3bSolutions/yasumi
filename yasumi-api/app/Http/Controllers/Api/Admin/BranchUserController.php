<?php

namespace App\Http\Controllers\Api\Admin;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\BranchAccess;

class BranchUserController extends Controller
{

    public function index (Request $request)
    {
        $branches = BranchAccess::where('branch_id', $request->branch_id)->pluck('user_id');
        return User::whereIn('id', $branches)->get();
    }

    public function store (Request $request)
    {
        $request->validate([
            'name' => 'required',
            'username' => 'required|unique:users,username',
            'role' => 'required',
            'password' => 'required|min:6'
        ]);

        $user = User::create($request->all());

        BranchAccess::create([
            'user_id' => $user->id,
            'branch_id' => $request->branch_id
        ]);

        return $user;
    }


    public function update (Request $request, $id)
    {
        $request->validate([
            'name' => 'required',
            'username' => 'required|unique:users,username,' . $id,
            'role' => 'required',
        ]);

        User::find($id)->update($request->all());

        return 1;
    }
}
