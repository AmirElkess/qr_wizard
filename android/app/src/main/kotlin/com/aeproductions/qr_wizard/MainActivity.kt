package com.aeproductions.qr_wizard

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
//import android.content.Context.WIFI_SERVICE
//import android.net.wifi.WifiManager
//import android.net.wifi.WifiConfiguration
import android.provider.Settings
import android.content.Intent

class MainActivity: FlutterActivity() {
    private val CHANNEL = "main/wifi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method.equals("openWifiSettings")) {
                Log.i("wifi", "inside native fn")
                startActivity(Intent(Settings.ACTION_WIFI_SETTINGS));
            }
        }
    }
}
