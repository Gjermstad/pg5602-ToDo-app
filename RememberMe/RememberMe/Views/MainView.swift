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
        .task {
            await ensureDefaultCategoryExists()
        }
    }
    
    // Her fikk jeg hjelp av ChatGPT for å sikre at det er en kategori til å starte med
    private func ensureDefaultCategoryExists() async {
        do {
            guard !seeded else { return }
            // 1) Sjekk om noe finnes (du kan også filtrere på title == "default")
            var descriptor = FetchDescriptor<CategoryModel>()
            descriptor.fetchLimit = 1
            // Valgfritt: sjekk spesifikt etter "default" så du ikke dupliserer
            descriptor.predicate = #Predicate { $0.title == "default" }

            let existing = try context.fetch(descriptor)
            guard existing.isEmpty else {
                seeded = true
                return
            }

            // 2) Sett inn én kategori
            context.insert(CategoryModel(title: "default"))

            // 3) Lagre
            try context.save()
            seeded = true
        } catch {
            print("Seeding-feil:", error.localizedDescription)
        }
    }
}

#Preview {
    MainView().modelContainer(for: [TaskModel.self, CategoryModel.self], inMemory: true)
}
