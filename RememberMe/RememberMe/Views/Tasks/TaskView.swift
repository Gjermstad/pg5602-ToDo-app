//
//  StartView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

import SwiftUI
import SwiftData

struct TaskView: View
{
    @Query private var tasks: [TaskModel]
    
    var body: some View
    {
        let filteredTasks = tasks.filter{!$0.archived}
        
        NavigationStack
        {
            Group
            {
                List
                {
                    ForEach(filteredTasks)
                    {
                        task in
                        
                        NavigationLink
                        {
                            
                        }
                    label:
                        {
                            Text(task.title)
                        }
                    }
                }
            }
            .navigationTitle("Oppgaver")
        }
    }
}

#Preview {
    TaskView()
}
