//
//  Queue.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import Foundation

final class Queue {
    
    static func main(_ closure: @escaping () -> Void) {
        DispatchQueue.main.async(execute: closure)
    }
    
    static func background(_ closure: @escaping () -> Void) {
        DispatchQueue(label: "queue.background").async(execute: closure)
    }
    
}
