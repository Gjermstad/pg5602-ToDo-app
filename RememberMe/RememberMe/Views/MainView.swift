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
    
    @AppStorage("darkmode") private var darkMode: Bool = false
    
    @State private var showSheet = false
    @State private var selectedTab = 0
    
    var body: some View
    {
        TabView(selection: $selectedTab) {
            TaskView().tabItem {
                Label("Oppgaver", systemImage: "list.bullet")
            }.tag(1)
            
            Color.clear.tabItem {
                Label("", systemImage: "plus")
            }.tag(2)
            
            SettingsView().tabItem {
                Label("Innstillinger", systemImage: "gear")
            }.tag(3)
        }
        .onChange(of: selectedTab, { oldvalue, newValue in
            if(newValue == 2) {
                showSheet = true;
                selectedTab = 0
            }
        })
        .environment(\.colorScheme, darkMode ? .dark : .light)
        .task {
            // Her sjekkes det om default-kateogrien finnes før første View blir vist på skjermen, hvis ikke lages kategorien
            _ = try? CategoryModel.getOrCreateSystemCategory(in: context)
        }
        .sheet(isPresented: $showSheet)
        {
            TaskAdd()
        }
    }
}

#Preview {
    MainView().modelContainer(for: [TaskModel.self, CategoryModel.self])
}
