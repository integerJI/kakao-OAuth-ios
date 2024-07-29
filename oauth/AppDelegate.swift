import UIKit
import KakaoSDKCommon

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: "ansjkfnknf9y7d9qh") // YOUR_KAKAO_CLIENT_ID
        return true
    }
}
