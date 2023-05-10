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
                signup()
            }
        }
        .padding()
    }

    private func signup() {
        Task {
            let userService = UserService()
            let user = User(username: username,
                            password: password,
                            email: email)

            do {
                try await userService.createUser(user: user)
                onSignup()
            } catch {
                print(error)
            }
        }
    }

    private func onSignup() {
        Task {
            do {
                userManager.user = User(username: username,
                                        password: password,
                                        email: email)
                _ = try await AccessTokenManager.shared.getJWTToken()
                if shouldRemmemberUser {
                    try remmemberUser()
                }
                userManager.isUserLoggedIn = true
            } catch {
            }
        }
    }

    private func remmemberUser() throws {
        let user = User(username: username,
                        password: password,
                        email: email)
        let data = try JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "user.credentials")
    }
}

struct SignupPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupPage()
    }
}
