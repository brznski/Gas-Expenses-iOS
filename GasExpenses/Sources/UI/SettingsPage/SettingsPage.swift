//
//  SettingsPage.swift
//  GasExpenses
//
//  Created by Michał Brzeziński on 07/05/2023.
//

import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        CardWithTitleView(title: "profile") {
            Button {
                Task {
                    await AccessTokenManager.shared.revokeJWTToken()
                    userManager.forgetUser()
                    userManager.isUserLoggedIn = false
                }
            } label: {
                Spacer()
                Text("logout")
                Spacer()
            }

        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
