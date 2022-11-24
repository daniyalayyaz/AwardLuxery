package com.example.gametest
import android.content.Intent
import com.awardluxury.ludothegame.UnityPlayerActivity
import com.awardluxury.ludothegame.UnityPlayerNativeActivity

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import  com.example.gametest.test

class MainActivity: FlutterActivity() {

//    val TAG: String = MainActivity::class.java.simpleName
    private val CHANNEL = "CreativeParkingSolution.example.com/map"
    private val MAP_METHOD_NAME = "umair"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->


            startActivity(Intent(applicationContext,test::class.java))
            result.success("done")


        }


    }

}
