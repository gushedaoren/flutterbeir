import UIKit
import Flutter



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate  {
 
var mwindow: UIWindow?
//var splash: GDTSplashAd!
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

//    UMCommonLogSwift.setUpUMCommonLogManager()
    
    UMConfigure.initWithAppkey("5f02bc7e895cca3b65000038", channel: "App Store")
   
            

    return true
  }
    
  
   
}
