//
//  RememberMeApp.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 01/10/2025.
//

import SwiftUI
import SwiftData

@main
struct RememberMeApp: App {
    
    // 1) Lager variabel som skal lagre alle schemas
    let container: ModelContainer
    
    init()
    {
        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "RememberMe.store"))
        
        do
        {
            // 2) setter opp databasemodellene vi trenger
            container = try ModelContainer(for: TaskModel.self, CategoryModel.self, configurations: config)
        }
        catch
        {
            fatalError("Feil ved åpning av databasen: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            // 3) Gi tilgang til alle schema ved å injisere variabelen med alle databasene på en gang
            MainView().modelContainer(container)
        }
    }
}
