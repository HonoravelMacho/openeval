package com.example.openeval.stockfish

import android.os.Handler
import android.os.Looper
import java.io.BufferedReader
import java.io.BufferedWriter
import java.io.File
import java.io.FileOutputStream
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.util.concurrent.Executors

class StockfishPlugin(private val context: com.example.openeval.MainActivity) {
    private var stockfishProcess: Process? = null
    private var reader: BufferedReader? = null
    private var writer: BufferedWriter? = null
    private val executor = Executors.newSingleThreadExecutor()
    private val handler = Handler(Looper.getMainLooper())
    private var isConfigured = false
    private var currentElo = 1500
    private var currentDepth = 25

    fun initialize(appDir: String, callback: (String) -> Unit) {
        executor.execute {
            try {
                copyStockfishBinary(appDir)
                startStockfish()
                handler.post { callback("success") }
            } catch (e: Exception) {
                handler.post { callback("error: ${e.message}") }
            }
        }
    }

    fun configure(elo: Int, depth: Int, infinite: Boolean, callback: (String) -> Unit) {
        currentElo = elo
        currentDepth = depth
        executor.execute {
            try {
                sendCommand("ucinewgame")
                sendCommand("setoption name UCI_LimitStrength value true")
                sendCommand("setoption name UCI_Elo value $elo")
                sendCommand("setoption name Skill Level value ${calculateSkill(elo)}")
                isConfigured = true
                handler.post { callback("success") }
            } catch (e: Exception) {
                handler.post { callback("error: ${e.message}") }
            }
        }
    }

    fun setPosition(fen: String, moves: List<String>, callback: (String) -> Unit) {
        executor.execute {
            try {
                val cmd = if (fen == "startpos") {
                    "position startpos moves ${moves.joinToString(" ")}"
                } else {
                    "position fen $fen moves ${moves.joinToString(" ")}"
                }
                sendCommand(cmd)
                handler.post { callback("success") }
            } catch (e: Exception) {
                handler.post { callback("error: ${e.message}") }
            }
        }
    }

    fun go(depth: Int, infinite: Boolean, callback: (Map<String, Any>) -> Unit) {
        executor.execute {
            try {
                val cmd = if (infinite) "go infinite" else "go depth $depth"
                sendCommand(cmd)
                
                val readerThread = object : Thread() {
                    override fun run() {
                        try {
                            while (true) {
                                val line = reader?.readLine() ?: break
                                if (line.startsWith("bestmove")) {
                                    val parts = line.split(" ")
                                    val bestMove = if (parts.size >= 2) parts[1] else ""
                                    val resultMap: Map<String, Any> = mapOf("type" to "bestmove", "move" to bestMove)
                                    handler.post { callback(resultMap) }
                                    break
                                } else if (line.startsWith("info")) {
                                    val info = parseInfoLine(line)
                                    if (info.isNotEmpty()) {
                                        handler.post { callback(info) }
                                    }
                                } else if (line == "readyok") {
                                    handler.post { callback(mapOf<String, Any>("type" to "readyok")) }
                                }
                            }
                        } catch (e: Exception) {
                            handler.post { callback(mapOf<String, Any>("type" to "error", "message" to (e.message ?: ""))) }
                        }
                    }
                }
                readerThread.start()
            } catch (e: Exception) {
                handler.post { callback(mapOf<String, Any>("type" to "error", "message" to (e.message ?: ""))) }
            }
        }
    }

    fun getBestMove(depth: Int, callback: (String) -> Unit) {
        executor.execute {
            try {
                sendCommand("go depth $depth")
                val readerThread = object : Thread() {
                    override fun run() {
                        try {
                            while (true) {
                                val line = reader?.readLine() ?: break
                                if (line.startsWith("bestmove")) {
                                    val parts = line.split(" ")
                                    callback(if (parts.size >= 2) parts[1] else "")
                                    break
                                }
                            }
                        } catch (e: Exception) {
                            callback("")
                        }
                    }
                }
                readerThread.start()
            } catch (e: Exception) {
                callback("")
            }
        }
    }

    fun stop() {
        executor.execute {
            try {
                sendCommand("stop")
            } catch (e: Exception) {}
        }
    }

    fun dispose() {
        executor.execute {
            try {
                sendCommand("quit")
                stockfishProcess?.destroy()
            } catch (e: Exception) {}
            stockfishProcess = null
            reader = null
            writer = null
        }
        executor.shutdown()
    }

    private fun copyStockfishBinary(appDir: String) {
        val sfPath = File("$appDir/stockfish")
        if (!sfPath.exists()) {
            val assetManager = context.assets
            val input = assetManager.open("stockfish-arm64")
            val output = FileOutputStream(sfPath)
            input.copyTo(output)
            output.close()
            input.close()
            sfPath.setExecutable(true)
        }
    }

    private fun startStockfish() {
        val sfPath = File("${context.getExternalFilesDir(null)}/stockfish")
        val processBuilder = ProcessBuilder(sfPath.absolutePath)
        processBuilder.directory(context.getExternalFilesDir(null))
        processBuilder.redirectErrorStream(true)
        stockfishProcess = processBuilder.start()
        reader = BufferedReader(InputStreamReader(stockfishProcess?.inputStream!!))
        writer = BufferedWriter(OutputStreamWriter(stockfishProcess?.outputStream!!))
    }

    private fun sendCommand(command: String) {
        writer?.write("$command\n")
        writer?.flush()
    }

    private fun parseInfoLine(line: String): Map<String, Any> {
        val result = mutableMapOf<String, Any>()
        val parts = line.split(Regex("\\s+"))
        var i = 0
        while (i < parts.size) {
            when (parts[i]) {
                "depth" -> { if (i + 1 < parts.size) result["depth"] = parts[++i].toInt() }
                "score" -> {
                    if (i + 2 < parts.size) {
                        result["scoreType"] = parts[i + 1]
                        result["score"] = parts[i + 2].toInt()
                    }
                    i += 2
                }
                "currmove" -> { if (i + 1 < parts.size) result["currmove"] = parts[i + 1] }
                "time" -> { if (i + 1 < parts.size) result["time"] = parts[i + 1].toInt() }
                "nodes" -> { if (i + 1 < parts.size) result["nodes"] = parts[i + 1].toInt() }
                "pv" -> {
                    val pvParts = parts.drop(i + 1).toList()
                    result["pv"] = pvParts.joinToString(" ")
                    i = parts.size
                }
            }
            i++
        }
        return result
    }

    private fun calculateSkill(elo: Int): Int {
        return ((elo - 200) / (2500 - 200) * 25 + 1).toInt().coerceIn(1, 25)
    }
}
