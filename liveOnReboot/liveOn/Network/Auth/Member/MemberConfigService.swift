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
    static func postMemeberInformation(information: PostMemberInformationDTO, completion: @escaping () -> ()) {
        singleton.signInMoyaService.request(.postMemberInformation(param: information)) { response in
            switch response {
                case .success:
                    completion()
                    return
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    static func getInviteCode(){
        singleton.signInMoyaService.request(.getCode) { response in
            switch response {
                case .success(let result):
                    do {
                        let data = try result.map(InviteCode.self)
                        singleton.fetchInviteCode(code: data.code)
                    } catch _ {
                        break
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    private func fetchInviteCode(code: String) {
        UserDefaults.standard.set(code, forKey: "inviteCode")
    }
    
    static func checkInviteCode(input: String, status: @escaping (Bool) -> ()) {
        singleton.signInMoyaService.request(.checkCode(param: input)) { response in
            switch response {
                case .success(let result):
                    if  (String(data: result.data, encoding: .utf8) == "success") {
                        status(true)
                    }
                    else{
                        status(false)
                        print("실패")
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
}
