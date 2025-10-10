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
    @State private var seeded = false // for å ikke kjøre .task flere ganger i Preview
    
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
        .onChange(of: selectedTab, {
            // Her jukser vi til at Color.clear fungerer som en fake View som lar oss vise modalen
            oldvalue, newValue in
            
            if(newValue == 2) {
                showSheet = true;
                selectedTab = 0
            }
        })
        .environment(\.colorScheme, darkMode ? .dark : .light) // Setter Dark Mode av/på
        .sheet(isPresented: $showSheet)
        {
            // View for å legge til ny oppgave vises som modal istedenfor fullskjerm
            TaskAdd()
        }
    }
}

#Preview {
    MainView().modelContainer(for: [TaskModel.self, CategoryModel.self], inMemory: false)
}
