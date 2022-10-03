//
//  CoupleService.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/10/03.
//

import Foundation
import Moya
import SwiftUI

class CoupleService: ObservableObject {
    let coupleProvider = MoyaProvider<CoupleEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
    @ObservedObject static var singleton: CoupleService = CoupleService()
    var isSuccessed: Bool = false
    static func getInviteCode(){
        singleton.coupleProvider.request(.getCode) { response in
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
        singleton.coupleProvider.request(.checkCode(param: input)) { response in
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
    
    static func postOfficialDate(officialDate: OfficialDate, completion: @escaping ()->()) {
        singleton.coupleProvider.request(.postOfficialdate(officialDate: officialDate)) { response in
            switch response {
                case .success(let result):
                    switch result.statusCode {
                        case 200..<300 :
                            singleton.isSuccessed = true
                        default :
                            break
                    }
                    completion()
                    
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    static func patchOfficialDate(officialDate: OfficialDate, completion: @escaping ()->()) {
        singleton.coupleProvider.request(.patchOfficialdate(officialDate: officialDate)) { response in
            switch response {
                case .success(let result):
                    switch result.statusCode {
                        case 200..<300 :
                            singleton.isSuccessed = true
                        default :
                            break
                    }
                    completion()
                    
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
}
