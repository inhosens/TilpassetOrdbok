package org.inhosens.JeBros;

import org.qtproject.qt5.android.QtNative;
import android.os.*;

import java.lang.String;
import android.content.Intent;
import android.util.Log;

public class QShareActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    public static boolean isIntentPending;
    public static boolean isInitialized;

    public static native void searchFromOtherApp(String text);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Get intent, action and MIME type
        Intent intent = getIntent();
        if (intent != null) {
            String action = intent.getAction();
            if (action != null) {
                //Log.d("TilpassetOrdbok onCreate ", action);
                isIntentPending = true;
            }
        }
    }

    @Override
    public void onDestroy() {
        Log.d("TilpassetOrdbok", "onDestroy QShareActivity");
        // super.onDestroy();
        // System.exit() closes the App before doing onCreate() again
        // then the App was restarted, but looses context
        // This works for Samsung My Files
        // but Google Files doesn't call onDestroy()
        System.exit(0);
    }

    // if we are opened from other apps:
    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        // Intent will be processed, if all is initialized and Qt / QML can handle the event
        if(isInitialized) {
            processIntent();
        } else {
            isIntentPending = true;
        }
    }

    public void checkPendingIntents() {
        isInitialized = true;
        Log.d("TilpassetOrdbok", "checkPandingIntents");
        if(isIntentPending) {
            isIntentPending = false;
            Log.d("TilpassetOrdbok", "checkPendingIntents: true");
            processIntent();
        } else {
            Log.d("TilpassetOrdbok", "no PendingIntents");
        }
    } // checkPendingIntents

    private void processIntent(){
        Intent intent = getIntent();

        // we are listening to android.intent.action.SEND or VIEW (see Manifest)
        String action = intent.getAction();
        String type = intent.getType();
        if (Intent.ACTION_SEND.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                handleSendText(intent); // Handle text being sent
            } else {
                Log.d("TilpassetOrdbok SEND Intent unknown type:", type);
            }
        } else {
            Log.d("TilpassetOrdbok Intent unknown action:", action);
            return;
        }
    }
        
    void handleSendText(Intent intent) {
        String sharedText = intent.getStringExtra(Intent.EXTRA_TEXT);
        if (sharedText != null) {
            // Update UI to reflect text being shared
            Log.d("TilpassetOrdbok handleSendText", sharedText);
            searchFromOtherApp(sharedText);
        }
    }
} // class QShareActivity
