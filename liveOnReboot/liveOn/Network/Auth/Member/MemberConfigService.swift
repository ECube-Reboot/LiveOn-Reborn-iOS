//
//  MemberConfigService.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/30.
//

import Foundation
import Moya

class MemberConfigService {
    static var singleton = MemberConfigService()
    let signInMoyaService = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin()])
    
    static func postMemeberInformation(information: PostMemberInformationDTO, completion: @escaping () -> ()) {
        singleton.signInMoyaService.request(.postMemberInformation(param: information)) { response in
            switch response {
                case .success(_):
                    completion()
                    return
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    static func getInviteCode() async {
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
}
