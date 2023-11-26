//
//  Providers.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/12/23.
//

import Foundation

import Moya

struct Providers {
    static let userProvider = MoyaProvider<UserRouter>(withAuth: true)
    static let chatbotProvider = MoyaProvider<ChatbotRouter>(withAuth: true)
    static let missionProvider = MoyaProvider<MissionRouter>(withAuth: true)
    static let statisticsProvider = MoyaProvider<StatisticsRouter>(withAuth: true)
    static let etcProvider = MoyaProvider<EtcRouter>(withAuth: true)
}

extension MoyaProvider {
  convenience init(withAuth: Bool) {
    if withAuth {
      self.init(session: Session(interceptor: AuthInterceptor.shared),
                plugins: [NetworkLoggerPlugin(verbose: true)])
    } else {
        self.init(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
  }
}
