<?php

namespace App\Http\Controllers\Api\Global;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use Illuminate\Http\Request;

class ActivityLogController extends Controller
{

    public function activityLogs (Request $request)
    {
        return ActivityLog::where('log_name', $request->log_name)->where('subject_id', $request->subject_id)->get();
    }

}
