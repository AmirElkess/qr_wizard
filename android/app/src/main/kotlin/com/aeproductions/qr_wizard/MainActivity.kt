package com.aeproductions.qr_wizard

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import android.content.Context.WIFI_SERVICE
import android.net.wifi.WifiManager
import android.net.wifi.WifiConfiguration


class MainActivity: FlutterActivity() {
    private val CHANNEL = "main/wifi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method.equals("connectWifi")) {
                val ssid = call.argument<String>("ssid").toString()
                val pwd = call.argument<String>("pwd").toString()
                Log.i("wifi", ssid)
                Log.i("wifi", pwd)


            }
        }
    }
}
