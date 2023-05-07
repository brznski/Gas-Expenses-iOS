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
    @State var repeatedPassword: String = ""
    @State var email: String = ""
    @State var shouldRemmemberUser: Bool = false
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack {
            TitleAndIconHeaderView<EmptyView>(title: "sign.up")

            Spacer()

            TitleAndTextField(title: "login",
                              textFieldValue: $username)
            TitleAndSecureField(title: "password",
                              textFieldValue: $password)
            TitleAndSecureField(title: "repeat.password",
                              textFieldValue: $repeatedPassword)
            TitleAndTextField(title: "email",
                              textFieldValue: $email)
            Toggle("remmember.me",
                   isOn: $shouldRemmemberUser)
            
            Spacer()

            ButtonPrimary {
                Text("sign.up")
            } action: {

            }
        }
        .padding()
    }
}

struct SignupPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupPage()
    }
}
