//
//  TaskModel.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

import Foundation
import SwiftData

@Model final class TaskModel
{
    @Attribute(.unique) var id: UUID
    var title: String
    var subTitle: String
    var category: CategoryModel
    var notes: String
    
    var startDate: Date
    var dueDate: Date
    
    var createdAt: Date
    var updatedAt: Date
    
    var status: Int8
    var priority: Bool
    var archived: Bool
    var reminderAt: Date
    
    init(title: String, subTitle: String = "", category: CategoryModel, notes: String = "", startDate: Date = .now, dueDate: Date = .now, status: Int8 = 0, priority: Bool = false, reminderAt: Date = .now) {
        self.id = UUID()
        self.title = title
        self.subTitle = subTitle
        self.category = category
        self.notes = notes
        self.startDate = startDate
        self.dueDate = dueDate
        self.createdAt = .now
        self.updatedAt = .now
        self.status = status
        self.priority = priority
        self.archived = false
        self.reminderAt = reminderAt
    }
}

// En falsk default-kategori som jeg kan bruke til eksempelTask1 i Previews
let defaultCategory = CategoryModel(title: "default")

let exampleTask1 = TaskModel(
    title: "Test: Rydd rommet",
    subTitle: "Mamma har mast hele uken",
    category: defaultCategory,
    notes: "Planen er at jeg skal starte med å kaste alt på sengen, så legger jeg det i en søppelsekk og kaster det inn i kottet. Mamma ser aldri der, må bare vente til hun drar bort.",
)
