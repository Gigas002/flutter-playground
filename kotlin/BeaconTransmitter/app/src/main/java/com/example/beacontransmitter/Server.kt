package com.example.beacontransmitter

import android.Manifest
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.core.content.ContextCompat

@Composable
fun GATTServerSample() {
    Log.w("Server Start","Spermer init")
    GATTServerScreen()
}

@Composable
internal fun GATTServerScreen() {
    Log.w("Server Start","Spermer constructorey")
    val context = LocalContext.current
    var enableServer by remember {
        mutableStateOf(GATTServerSampleService.isServerRunning.value)
    }
    var enableAdvertising by remember(enableServer) {
        mutableStateOf(enableServer)
    }
    val logs by GATTServerSampleService.serverLogsState.collectAsState()

    LaunchedEffect(enableServer, enableAdvertising) {
        val intent = Intent(context, GATTServerSampleService::class.java).apply {
            action = if (enableAdvertising) {
                GATTServerSampleService.ACTION_START_ADVERTISING
            } else {
                GATTServerSampleService.ACTION_STOP_ADVERTISING
            }
        }
        if (enableServer) {
            Log.w("Server Start","Enable pls")
            ContextCompat.startForegroundService(context, intent)
        } else {
            Log.w("Server Start","no enabley")
            context.stopService(intent)
        }
    }

    Column(
        Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(16.dp),
    ) {
        Row(
            Modifier
                .fillMaxWidth()
                .padding(horizontal = 8.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
        ) {
            Button(onClick = { enableServer = !enableServer }) {
                Text(text = if (enableServer) "Stop Server" else "Start Server")
            }

            Button(onClick = { enableAdvertising = !enableAdvertising }, enabled = enableServer) {
                Text(text = if (enableAdvertising) "Stop Advertising" else "Start Advertising")
            }
        }
        Text(text = logs)
    }
}
