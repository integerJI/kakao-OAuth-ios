import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire

struct ContentView: View {
    @State private var showingLoginAlert = false
    @State private var loginMessage = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                kakaoLogin()
            }) {
                Text("Login with Kakao")
            }
        }
        .padding()
        .alert(isPresented: $showingLoginAlert) {
            Alert(title: Text("Login Status"), message: Text(loginMessage), dismissButton: .default(Text("OK")))
        }
    }

    func kakaoLogin() {
        // 카카오톡이 설치되어 있는지 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡으로 로그인
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                    loginMessage = "Login failed: \(error.localizedDescription)"
                    showingLoginAlert = true
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    if let oauthToken = oauthToken {
                        sendTokenToServer(oauthToken: oauthToken.accessToken)
                    }
                }
            }
        } else {
            // 카카오 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                    loginMessage = "Login failed: \(error.localizedDescription)"
                    showingLoginAlert = true
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    if let oauthToken = oauthToken {
                        sendTokenToServer(oauthToken: oauthToken.accessToken)
                    }
                }
            }
        }
    }

    func sendTokenToServer(oauthToken: String) {
        let url = "http://11.11.11:8000/oauth/kakao/login/callback/" // Django 서버의 콜백 URL
        let parameters: [String: Any] = [
            "access_token": oauthToken
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Token sent to server successfully: \(value)")
                    loginMessage = "Login success: \(value)"
                    showingLoginAlert = true
                case .failure(let error):
                    print("Error sending token to server: \(error)")
                    loginMessage = "Error sending token to server: \(error.localizedDescription)"
                    showingLoginAlert = true
                }
            }
    }
}

#Preview {
    ContentView()
}
