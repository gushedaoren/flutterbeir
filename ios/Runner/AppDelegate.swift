import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//    let config = UMAnalyticsConfig.sharedInstance()
//    config?.appKey = "5f02bc7e895cca3b65000038"
//    config?.channelId = "app store" //enterprise   App Store
//    MobClick.start(withConfigure: config)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    override func applicationDidFinishLaunching(_ application: UIApplication) {
       
    }
    
   
}
