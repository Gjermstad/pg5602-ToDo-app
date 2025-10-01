//
//  ContentView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 01/10/2025.
//

import SwiftUI
import SwiftData

struct MainView: View {

    var body: some View
    {
        TabView {
            StartView().tabItem {
                Label("Start", systemImage: "house")
            }
            
            ItemAdd().tabItem {
                Label("", systemImage: "plus") 
            }
            
            SettingsView().tabItem {
                Label("Innstillinger", systemImage: "gear")
            }
        }
    }
}

#Preview {
    MainView()
}
