//
//  SignInLayoutViewBuilder.swift
//  liveOnReboot
//
//  Created by Jineeee on 2022/08/20.
//

import Foundation
import SwiftUI

struct SignInLayoutView<InputForm: View>: View {
    let title: String
    let description: String
    let inputForm: InputForm
    
    init(title: String, description: String, @ViewBuilder inputForm: () -> InputForm) {
        self.title = title
        self.description = description
        self.inputForm = inputForm()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Text(description)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 64)
            inputForm
            Spacer()
        }
        .foregroundColor(.textBodyColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .background(Color.backgroundGray)
        .navigationBarBackButtonHidden(true)
    }
}
