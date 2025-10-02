//
//  SettingsView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("darkmode") private var darkMode: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section()
                {
                    Toggle("Aktiver mørk modus",
                           systemImage: darkMode ? "moon.zzz" : "moon.circle",
                           isOn: $darkMode
                    )
                }
            }
            .navigationTitle("Innstillinger")
        }
    }
}

#Preview {
    SettingsView()
}
