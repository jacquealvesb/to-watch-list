//
//  CoreDataService.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 22/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class CoreDataService {
    public static let shared = CoreDataService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "to_watch_list_rxswift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print(storeDescription)
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    func saveContext () {
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertMovie(_ movie: Movie) {
        let coreDataModel = MovieCD(context: self.context)
        
        coreDataModel.id = Int16(movie.id)
        coreDataModel.title = movie.title
        coreDataModel.overview = movie.overview
        coreDataModel.posterPath = movie.posterPath
        coreDataModel.releaseDate = movie.releaseDate
        coreDataModel.status = Int16(movie.status.rawValue)
        coreDataModel.review = movie.review
        coreDataModel.watchedDate = movie.watchedDate
        
        if let rating = movie.rating {
            coreDataModel.rating = Int16(rating)
        }
        
        self.saveContext()
    }
    
    func fetchMovies(completion: @escaping (_ movies: [Movie], _ error: Error?) -> Void) {
        let fetchRequest = NSFetchRequest<MovieCD>(entityName: "MovieCD")
        
        do {
            let moviesCDModels = try self.context.fetch(fetchRequest)
            var movies = [Movie]()
            
            for movieCD in moviesCDModels {
                let movie = Movie(id: Int(movieCD.id),
                                  title: movieCD.title ?? "",
                                  overview: movieCD.overview ?? "",
                                  releaseDate: movieCD.releaseDate ?? Date(),
                                  posterPath: movieCD.posterPath)
                
                movies.append(movie)
            }
            
            completion(movies, nil)
        } catch {
            print(error)
            completion([], nil)
        }
    }
    
    func delete(_ object: NSManagedObject) {
        self.context.delete(object)
        
        self.saveContext()
    }
}
