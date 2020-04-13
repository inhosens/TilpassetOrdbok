package org.inhosens.JeBros;

import org.qtproject.qt5.android.QtNative;
import android.os.*;

import java.lang.String;
import android.content.Intent;
import android.util.Log;

public class QShareActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
    public static native void searchFromOtherApp(String text);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Get intent, action and MIME type
        Intent intent = getIntent();
        String action = intent.getAction();
        String type = intent.getType();

        if (Intent.ACTION_SEND.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                handleSendText(intent); // Handle text being sent
            }
        }
    }

    void handleSendText(Intent intent) {
        String sharedText = intent.getStringExtra(Intent.EXTRA_TEXT);
        if (sharedText != null) {
            // Update UI to reflect text being shared
            Log.d("TilpassetOrdbok", sharedText);
            searchFromOtherApp(sharedText);
        }
    }
} // class QShareActivity
