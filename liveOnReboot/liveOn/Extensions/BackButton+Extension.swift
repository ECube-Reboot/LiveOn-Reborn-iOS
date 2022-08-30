//
//  BackButton+Extension.swift
//  liveOnReboot
//
//  Created by Jisu Jang on 2022/07/19.
//
import SwiftUI

extension View {
    
    /// 이전 페이지로 돌아가는 버튼으로 @Environment(\.dismiss) var dismiss와 함께 사용합니다
    func navigationToBack( _ dismissAction: DismissAction) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismissAction()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                }
            }
    }
    
    func navigationToBackShowOptional( _ dismissAction: DismissAction, isHidden: Bool) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !isHidden {
                        Button(action: {
                            dismissAction()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
    }
    
    
    func navigationCancel( _ dismissAction: DismissAction) -> some View {
        navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismissAction()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

