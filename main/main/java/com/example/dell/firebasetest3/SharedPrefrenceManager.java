package com.example.dell.firebasetest3;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;

/**
 * Created by DELL on 7/15/2017.
 */

public class SharedPrefrenceManager {

    private static final String SHARED_PREF_NAME = "firebasedemo";
    private static final String KEY_ACCESS_TOKEN = "token";

    private static Context mCtx;
    private static SharedPrefrenceManager mInstance;

    private SharedPrefrenceManager(Context context) {
        mCtx = context;
    }

    public static synchronized SharedPrefrenceManager getInstance(Context context) {
        if (mInstance == null)
            mInstance =  new SharedPrefrenceManager(context);
        return mInstance;
    }

    public boolean storeToken(String token) {
        SharedPreferences sharedPreferences = mCtx.getSharedPreferences(SHARED_PREF_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(KEY_ACCESS_TOKEN, token);
        editor.apply();
        return true;
    }

    public String getToken() {
        SharedPreferences sharedPreferences = mCtx.getSharedPreferences(SHARED_PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_ACCESS_TOKEN, null);
    }
}
