//
//  ContentView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 01/10/2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View
    {
        TabView {
            StartView().tabItem {
                Label("Start", systemImage: "house")
            }
            .task {
                // Her sjekkes det om default-kateogrien finnes før første View blir vist på skjermen, hvis ikke lages kategorien
                _ = try? CategoryModel.getOrCreateSystemCategory(in: context)
            }
            
            TaskAdd().tabItem {
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
