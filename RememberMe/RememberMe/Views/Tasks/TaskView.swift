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
                if(filteredTasks.isEmpty)
                {
                    EmptyView()
                }
                else
                {
                    List
                    {
                        ForEach(filteredTasks) { task in
                            NavigationLink
                            {
                                TaskEdit(task: task)
                            }
                            label:
                            {
                                TaskRow(task: task)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Oppgaver")
        }
    }
}

#Preview {
    TaskView().modelContainer(for: [TaskModel.self, CategoryModel.self])
}
