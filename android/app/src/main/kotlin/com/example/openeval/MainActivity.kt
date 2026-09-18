package com.example.openeval

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.openeval.stockfish.StockfishPlugin

class MainActivity : FlutterActivity() {
    private var stockfishPlugin: StockfishPlugin? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        stockfishPlugin = StockfishPlugin(this)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "stockfish_engine")
        
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    val appDir = call.argument<String>("appDir") ?: ""
                    stockfishPlugin?.initialize(appDir) { status ->
                        result.success(status)
                    }
                }
                "configure" -> {
                    val elo = call.argument<Int>("elo") ?: 1500
                    val depth = call.argument<Int>("depth") ?: 25
                    val infinite = call.argument<Boolean>("infinite") ?: false
                    val skill = call.argument<String>("skill")
                    stockfishPlugin?.configure(elo, depth, infinite) { status ->
                        result.success(status)
                    }
                }
                "position" -> {
                    val fen = call.argument<String>("fen") ?: "startpos"
                    val moves = call.argument<List<String>>("moves") ?: emptyList()
                    stockfishPlugin?.setPosition(fen, moves) { status ->
                        result.success(status)
                    }
                }
                "go" -> {
                    val depth = call.argument<Int>("depth") ?: 25
                    val infinite = call.argument<Boolean>("infinite") ?: false
                    stockfishPlugin?.go(depth, infinite) { info ->
                        result.success(info)
                    }
                }
                "getBestMove" -> {
                    val depth = call.argument<Int>("depth") ?: 25
                    stockfishPlugin?.getBestMove(depth) { move ->
                        result.success(move)
                    }
                }
                "stop" -> {
                    stockfishPlugin?.stop()
                    result.success("stopped")
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        stockfishPlugin?.dispose()
        super.onDestroy()
    }
}
