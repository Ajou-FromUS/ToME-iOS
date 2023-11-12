//
//  UserManager.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/12/23.
//

import Foundation

import Moya

enum ToMEError: Error {
    case networkFail
    case etc
}

final class UserManager {
    static let shared = UserManager()
    
    private var userProvider = Providers.userProvider
    private var etcProvider = Providers.etcProvider
    
    @UserDefaultWrapper<String>(key: "accessToken") public var accessToken
    @UserDefaultWrapper<String>(key: "refreshToken") public var refreshToken

    var hasAccessToken: Bool { return self.accessToken != nil }
    
    private init() {}
    
    func updateToken(accessToken: String, refreshToken: String, isKakao: Bool) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
//    func signIn(token: String, provider: String, completion: @escaping(Result<String, ToMEError>) -> Void) {
//        userProvider.request(.createUser(token: token, provider: provider)) { [weak self] response in
//            guard let self = self else { return }
//            switch response {
//            case .success(let result):
//                let status = result.statusCode
//                if 200..<300 ~= status {
//                    do {
////                        let responseDto = try result.map(BaseResponse<SignInResponseDto>.self)
////                        guard let data = responseDto.data else { return }
////                        self.accessToken = data.accessToken
////                        self.refreshToken = data.refreshToken
////                        self.isKakao = provider == "KAKAO" ? true : false
////                        completion(.success(data.type)) // 로그인인지 회원가입인지 전달
//                    } catch {
//                        print(error.localizedDescription)
//                        completion(.failure(.networkFail))
//                    }
//                }
//                if status >= 400 {
//                    print("400 error")
//                    completion(.failure(.networkFail))
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(.failure(.networkFail))
//            }
//        }
//    }
    
    func getNewToken(completion: @escaping(Result<Bool, ToMEError>) -> Void) {
        etcProvider.request(.getRefreshToken) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                let status = result.statusCode
                if 200..<300 ~= status {
                    do {
//                        let responseDto = try result.map(BaseResponse<GetNewTokenResponseDto>.self)
//                        guard let data = responseDto.data else { return }
//                        self.accessToken = data.accessToken
//                        self.refreshToken = data.refreshToken
                        completion(.success(true))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(.networkFail))
                    }
                }
                if status >= 400 {
                    print("400 error")
                    completion(.failure(.networkFail))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkFail))
            }
        }
    }
    
    func logout() {
        self.resetTokens()
    }
    
    private func resetTokens() {
        self.accessToken = nil
        self.refreshToken = nil
    }
}
