//
//  SignupPage.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import SwiftUI

struct SignupPage: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var shouldRemmemberUser: Bool = false
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack {
            TitleAndIconHeaderView<EmptyView>(title: "sign.up")
            TitleAndTextField(title: "login",
                              textFieldValue: $username)
            TitleAndTextField(title: "password",
                              textFieldValue: $password)
            TitleAndTextField(title: "repeat.password",
                              textFieldValue: $password)
            TitleAndTextField(title: "email",
                              textFieldValue: $password)
            Toggle("remmember.me", isOn: $shouldRemmemberUser)
            Button {
            } label: {
                Spacer()
                Text("sign.up")
                Spacer()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct SignupPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupPage()
    }
}
