//
//  EmptyView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 05/10/2025.
//

import SwiftUI

struct EmptyView: View
{
    var title: String
    var note: String
    
    init(
            title: String = "Alle oppgaver er fullført",
            note: String = "Trykk på + for å legge til en ny"
        )
    {
        self.title = title
        self.note = note
    }
    
    var body: some View
    {
        ContentUnavailableView(title, systemImage: "checklist.unchecked", description: Text(note))
    }
}

#Preview {
    EmptyView()
}
