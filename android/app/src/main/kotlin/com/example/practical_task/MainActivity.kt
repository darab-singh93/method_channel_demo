package com.example.practical_task

import android.bluetooth.BluetoothAdapter
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.Manifest
import android.app.AlertDialog
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.content.DialogInterface
import android.widget.Toast


class MainActivity : FlutterActivity() {
    private val channelName = "bluetooth_channel"
    private val BLUETOOTH_PERMISSION_REQUEST = 1

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                if (call.method == "enableBluetooth") {
                    // Call the method to enable Bluetooth
                    enableBluetooth()
                    result.success(true) // Return the result to Flutter
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun enableBluetooth() {
//        showPermissionAlertDialog()
        checkBluetoothPermission()
    }

    private fun checkBluetoothPermission() {
        val permission = Manifest.permission.BLUETOOTH
        val hasPermission = ContextCompat.checkSelfPermission(this, permission)
        if (hasPermission != PackageManager.PERMISSION_GRANTED) {
            // Request Bluetooth permission with alert
            showPermissionAlertDialog()
        } else {
            // Bluetooth permission already granted
            val mBluetoothAdapter: BluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
            if (!mBluetoothAdapter.isEnabled) {
                mBluetoothAdapter.enable()
                Toast.makeText(this@MainActivity, "Bluetooth is enabled!", Toast.LENGTH_SHORT).show()
            }else{
                Toast.makeText(this@MainActivity, "Bluetooth is already enabled!", Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        when (requestCode) {
            BLUETOOTH_PERMISSION_REQUEST -> {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    // Bluetooth permission granted
                    // Proceed with Bluetooth operations
                    val mBluetoothAdapter: BluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    if (ActivityCompat.checkSelfPermission(
                            this,
                            Manifest.permission.BLUETOOTH_CONNECT
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {
                        // TODO: Consider calling
                        //    ActivityCompat#requestPermissions
                        // here to request the missing permissions, and then overriding
                        //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                        //                                          int[] grantResults)
                        // to handle the case where the user grants the permission. See the documentation
                        // for ActivityCompat#requestPermissions for more details.
                        return
                    }
                    mBluetoothAdapter.enable()
                    Toast.makeText(this@MainActivity, "Bluetooth is enabled!", Toast.LENGTH_SHORT).show()
                } else {
                    // Bluetooth permission denied
                    // Handle accordingly
                }
                return
            }
        }
    }

    private fun showPermissionAlertDialog() {
        val alertDialogBuilder = AlertDialog.Builder(this)
        alertDialogBuilder.setTitle("Bluetooth Permission")
        alertDialogBuilder.setMessage("This app requires Bluetooth permission.")
        alertDialogBuilder.setPositiveButton("Grant") { dialogInterface: DialogInterface, _: Int ->
            dialogInterface.dismiss()
            requestBluetoothPermission()
        }
        alertDialogBuilder.setNegativeButton("Deny") { dialogInterface: DialogInterface, _: Int ->
            dialogInterface.dismiss()
            // Handle Bluetooth permission denied
        }
        val alertDialog = alertDialogBuilder.create()
        alertDialog.show()
    }

    private fun requestBluetoothPermission() {
        val permission = Manifest.permission.BLUETOOTH
        ActivityCompat.requestPermissions(this, arrayOf(permission), BLUETOOTH_PERMISSION_REQUEST)
    }
}
