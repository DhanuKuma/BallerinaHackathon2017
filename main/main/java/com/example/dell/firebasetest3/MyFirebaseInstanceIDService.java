package com.example.dell.firebasetest3;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;

public class MyFirebaseInstanceIDService extends FirebaseInstanceIdService {
    private final static String TAG = MyFirebaseInstanceIDService.class.getSimpleName();
    public final static String TOKEN_BROADCAST = "tokenbroadcast";
    @Override
    public void onTokenRefresh() {
        // Get updated InstanceID token.
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
        Log.d(TAG, "Refreshed token: " + refreshedToken);

        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.
//        sendRegistrationToServer(refreshedToken);
        storeToken(refreshedToken);
        getApplicationContext().sendBroadcast(new Intent(TOKEN_BROADCAST));
    }

    private void storeToken(String token) {
        SharedPrefrenceManager.getInstance(getApplicationContext()).storeToken(token);
    }
}
