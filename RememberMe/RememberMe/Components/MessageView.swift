//
//  MessageView.swift
//  RememberMe
//
//  Created by Kenneth Andre Bettum Gjermstad on 10/10/2025.
//

import SwiftUI

struct MessageView: View
{
  var text: String
  
  var body: some View
  {
    HStack
    {
      Image(systemName: "info.circle.fill")
        .font(.title)
        .padding(10)
      Text(text)
        .padding(10)
      Spacer()
    }
    .background(.green)
    .cornerRadius(10)
    .padding(.horizontal, 20)
  }
}

#Preview {
  MessageView(text: "Dette er en eksempeltekst jeg kan sende inn.")
}
