import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let bluetoothChannel = FlutterMethodChannel(name: "bluetooth_channel", binaryMessenger: controller.binaryMessenger)
    bluetoothChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if call.method == "enableBluetooth" {
            // Call the method to enable Bluetooth
            self?.enableBluetooth(result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func enableBluetooth(result: @escaping FlutterResult) {
      guard let controller = window?.rootViewController else {
          result(false)
          return
      }

      // Check if Bluetooth is already enabled
      let centralManager = CBCentralManager()
      if centralManager.state == .poweredOn {
          result(true)
          return
      }
      // Request Bluetooth authorization
      centralManager.delegate = self
      centralManager.scanForPeripherals(withServices: nil, options: nil)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          centralManager.stopScan()
          result(true)
      }

      // Show Bluetooth permission dialog
      let alert = UIAlertController(title: "Enable Bluetooth", message: "This app requires Bluetooth to be enabled. Please enable Bluetooth in the settings.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
          if let url = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
          }
      }))
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
          result(false)
      }))
      controller.present(alert, animated: true, completion: nil)
  }

}
