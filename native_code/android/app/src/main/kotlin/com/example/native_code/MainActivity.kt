package com.example.native_code

import kotlin.random.Random
import android.content.res.Configuration
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.content.pm.ActivityInfo
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler

class MainActivity: FlutterActivity() {
    var events: EventSink? = null
    var oldConfig: Configuration? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        oldConfig = Configuration(context.resources.configuration)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

//        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel").setStreamHandler(
//            object: StreamHandler {
//                override fun onListen(arguments: Any?, es: EventSink?) {
//                    events = es
//                    events?.success(isDarkMode(oldConfig))
//                }
//
//                override fun onCancel(arguments: Any?) {
//                }
//            }
//        )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/channel").setMethodCallHandler { call, result ->
            when (call.method) {
                "getRandomNumber" -> {
                    val rand = Random.nextInt(100)
                    result.success(rand)
                }
                "getRandomString" -> {
                    val limit = call.argument("len") ?: 4
                    val prefix = call.argument("prefix") ?: ""
                    val rand = ('a'..'z')
                        .shuffled()
                        .take(limit)
                        .joinToString(prefix = prefix, separator = "")
                    result.success(rand)
                }
                "isDarkMode" -> {
                    val mode = context
                        .resources
                        .configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK
                    result.success(mode == Configuration.UI_MODE_NIGHT_YES)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)

        if (isDarkModeConfigUpdated(newConfig)) {
            events?.success(isDarkMode(newConfig))
        }

        oldConfig = Configuration(newConfig)
    }

    private fun isDarkModeConfigUpdated(config: Configuration): Boolean {
        return (config.diff(oldConfig) and ActivityInfo.CONFIG_UI_MODE) != 0 && isDarkMode(config) != isDarkMode(oldConfig)
    }

    fun isDarkMode(config: Configuration?): Boolean {
        return config!!.uiMode and Configuration.UI_MODE_NIGHT_MASK == Configuration.UI_MODE_NIGHT_YES
    }
}