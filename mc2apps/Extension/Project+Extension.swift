//
//  Project+Extension.swift
//  mc2apps
//
//  Created by danny santoso on 17/05/20.
//  Copyright © 2020 danny santoso. All rights reserved.
//

import Foundation
import CoreData

extension Project{
    static func fetchQuery(viewCopntext: NSManagedObjectContext) -> [Project]{
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        
        let predicate = NSPredicate(format: "taskName BEGINSWITH @%", [])
        request.predicate = predicate
        let result = try? viewCopntext.fetch(request)
        return result ?? []
        
    }
    
    static func fetchAll(viewContext: NSManagedObjectContext) -> [Project] {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        
        guard let result = try? viewContext.fetch(request) else{
            return []
        }
        return result
    }
    
    static func save(viewContext: NSManagedObjectContext, projectName: String, clientName: String, deadline: Date, color: String, isCompleted: Bool, projectCompletionReward: String) -> Project? {
        let project = Project(context: viewContext)
        project.projectName = projectName
        project.clientName = clientName
        project.deadline = deadline
        project.color = color
        project.projectCompletionReward = projectCompletionReward
        project.isCompleted = isCompleted
        
        do {
            try viewContext.save()
            return project
        } catch  {
            return nil
        }
        
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext){

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Project")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try? viewContext.execute(deleteRequest)
        
    }
}