//
//  SettingsView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("darkmode") private var darkMode: Bool = false
    
    @State private var path = ""
    
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
                
                Section
                {
                  Button
                  {
                    // Sjekker om path-variabelen er tom
                    if path.isEmpty
                    {
                      // Hvis tom: hent filstien til dokumentmappen og lagre i path
                      path = URL.documentsDirectory.path()
                      print(path) // Skriver ut stien til Xcode-debug-konsollen
                    }
                    else
                    {
                      // Hvis path allerede har verdi: "tøm" den (slik at teksten skjules)
                      path = ""
                    }
                  }
                  label:
                  {
                    Label(path.isEmpty ? "Vis lokal database-lokasjon" : "Skjul database lokasjon", systemImage: "square.stack.3d.up.fill")
                  }
                  
                  // Viser stien som tekst under knappen, men bare hvis path har verdi
                  if !path.isEmpty
                  {
                    Text(path)
                    
                    Button
                    {
                      // Kopierer innholdet av variabelen til systemets utklippstavle,
                      // slik at brukeren kan lime det inn i andre apper.
                      UIPasteboard.general.string = path
                    }
                    label:
                    {
                      Label("Kopier til utklippstavle", systemImage: "document.on.document.fill")
                    }
                  }
                }
            }
            .navigationTitle("Innstillinger")
        }
    }
}

#Preview {
    SettingsView()
}
