//
//  MemberConfigService.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/30.
//

import Foundation
import Moya
import SwiftUI

class MemberConfigService: ObservableObject {
    let signInMoyaService = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin()])
    let memberConfigProvider = MoyaProvider<MemberConfigEndPoint>(plugins: [NetworkLoggerPlugin()])
    
    @ObservedObject static var singleton: MemberConfigService = MemberConfigService()
    @Published var profile = FetchMemberProfile()
    @State var isSuccess = false
    @Published var isMatched = false
    
    static func postMemeberInformation(information: PostMemberProfile, completion: @escaping () -> ()) {
        singleton.memberConfigProvider.request(.postMemberProfile(param: information)) { response in
            switch response {
                case .success(let result):
                    switch result.statusCode {
                    case 200..<300:
                            completion()
                    default :
                            break
                }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    static func fetchMemberProfile(completion: @escaping () -> ()) {
        singleton.memberConfigProvider.request(.fetchMemberProfile) { response in
            switch response {
                case .success(let result):
                    do {
                    let data = try result.map(FetchMemberProfile.self)
                        singleton.profile = data
                        completion()
                    }
                    catch _ {
                        break
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    

    static func revokeMember(completion: @escaping () -> ()) {
        singleton.memberConfigProvider.request(.revokeMember) { response in
            switch response {
                case .success:
                    completion()
                    return
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }

    static func editNickName(currentNickName: String, completion: @escaping () -> ()) {
        singleton.memberConfigProvider.request(.editNickName(param: EditNickNameRequest(nickName: currentNickName))) { response in
            switch response {
                case .success:
                    completion()
                    break
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    static func validateCoupleMatching(completion: @escaping () -> ()) {
        singleton.memberConfigProvider.request(.validateCoupleMatching) { response in
            switch response {
                case .success(let result):
                    switch result.statusCode {
                        case 200..<300:
                            do {
                                let data = try result.map(IsCoupleMatched.self)
                                if data.coupleMatched {
                                    singleton.isMatched = true
                                    completion()
                                }
                            } catch _ {
                                break
                            }
                        default :
                            break
                    }
                case .failure:
                    break
            }
        }
    }
    
}
