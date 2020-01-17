//
//  PersistenceHelper.swift
//  Scheduler
//
//  Created by David Lin on 1/17/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

enum dataPersistenceError: Error { // conforming to the Error Protocol
    case savingError(Error) // associated value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
}

class PersistenceHelper {
    
    // CRUD - create, read, update, delete
    
    // array of events
    private static var events = [Event]()
    
    private static let filename = "schedules.plist"
    
    // create - save item to documents directory
    static func save(event: Event) throws {
        
        // STEP 1
        // get url to path to the file that the event will be saved to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // STEP 2
        // append new event to the events array
        events.append(event)
        
        // events arrray will be object being converted to Data
        // we will use the Data object to and write (save) it to documents
        do {
            
            // STEP 3
            // convert (serialize) the events array to data
            let data = try PropertyListEncoder().encode(events)
            
            //STEP 4
            // writes, saves, persists the data to the documentsdirectory
            try data.write(to: url, options: .atomic)
        } catch {
            // STEP 5
            throw dataPersistenceError.savingError(error)
        }
    }
    
    // read - load (retrieve) items from documents directory
    static func loadEvents() throws -> [Event] {
        // we need access to the filename URL that wea re reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if file exists
        // to convert URL to string, we use .path on the URL
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    events = try PropertyListDecoder().decode([Event].self, from: data)
                } catch {
                    throw dataPersistenceError.decodingError(error)
                    
                }
            } else {
                throw dataPersistenceError.noData
            }
    } else {
            throw dataPersistenceError.fileDoesNotExist(filename)
    }
    return events
}

// update -




// delete - remove item from documents directory

}


