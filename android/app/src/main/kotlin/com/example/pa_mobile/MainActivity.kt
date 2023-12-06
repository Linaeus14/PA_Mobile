package com.example.pa_mobile;

import android.content.Context;
import androidx.multidex.MultiDex;
import io.flutter.embedding.android.FlutterActivity;

class MainActivity extends FlutterActivity {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
