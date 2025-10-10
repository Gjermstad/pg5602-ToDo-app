//
//  CategoryModel.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

// IKKE I BRUK - JEG KLARTE IKKE Å IMPLEMENTERE KATEGORIER SLIK JEG FØRST TENKTE OG GIKK BORT FRA DET

import Foundation
import SwiftData

@Model final class CategoryModel
{
    var id: UUID
    @Attribute(.unique) var title: String
    var categoryDescription: String
    var color: String
    var icon: String
    
    var favorite: Bool
    var archived: Bool
    
    var createdAt: Date
    var updatedAt: Date
    
    var tasks: [TaskModel]?
    
    init(title: String, categoryDescription: String = "", color: String = "blue", icon: String = "list.bullet") {
        self.id = UUID()
        self.title = title
        self.categoryDescription = categoryDescription
        self.color = color
        self.icon = icon
        self.favorite = false
        self.archived = false
        self.createdAt = .now
        self.updatedAt = .now
    }
}

let categoryExample = CategoryModel(title: "Testkategori", categoryDescription: "Testkategori for utvikling")

// Følgende kode har jeg fått hjelp av ChatGPT til å lage da jeg ikke klarte å lage en default-kategori selv
// Den gir en statisk ID som vi bruker for å lage en default-kategori som alltid skal finnes
extension CategoryModel {
    static let systemID = UUID(uuidString: "11111111-2222-3333-4444-555555555555")!

    static func getOrCreateSystemCategory(in context: ModelContext) throws -> CategoryModel {
        let fetch = FetchDescriptor<CategoryModel>(
            predicate: #Predicate { $0.id == systemID }
        )
        if let found = try context.fetch(fetch).first {
            return found
        }

        let sys = CategoryModel(title: "default")
        sys.id = systemID
        context.insert(sys)
        try context.save()
        return sys
    }
}
