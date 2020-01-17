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
}

class PersistenceHelper {
    
// CRUD - create, read, update, delete

// array of events
private static var events = [Event]()

private static let filename = "schedules.plist"
    
// create - save item to documents directory
static func save(event: Event) throws {
    
    
    // get url to path to the file that the event will be saved to
    let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    // append new event to the events array
    events.append(event)

    // events arrray will be object being converted to Data
    // we will use the Data object to and write (save) it to documents
    do {
        let data = try PropertyListEncoder().encode(events)
        try data.write(to: url, options: .atomic)
    } catch {
        throw dataPersistenceError.savingError(error)
    }
    
    
// read - load (retrieve) items from documents directory


// update -




// delete - remove item from documents directory
 
}

}
