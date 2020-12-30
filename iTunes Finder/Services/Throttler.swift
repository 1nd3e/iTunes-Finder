//
//  Throttler.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 31.12.2020.
//

import Foundation

final class Throttler {
    
    // MARK: - Types
    
    typealias ThrottleBlock = () -> Void
    
    // MARK: - Properties
    
    private var workItem = DispatchWorkItem(block: {})
    private var previousWorkItemRun = Date.distantPast
    
    private let queue: DispatchQueue
    private let delay: TimeInterval
    
    // MARK: - Initializers
    
    init(delay: TimeInterval, queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue
    }
    
    // MARK: - Methods
    
    func throttle(_ block: @escaping ThrottleBlock) {
        // Cancel any existing work item if it has not yet executed.
        workItem.cancel()

        // Re-assign work item with the new block, resetting
        // the previous run time when it executes.
        workItem = DispatchWorkItem() { [weak self] in
            self?.previousWorkItemRun = Date()
            
            block()
        }

        // If the time since the previous run is more than the required delay
        // then execute the work item immediately. Otherwise, delay the work item
        // execution by the delay time.
        let delayTime = previousWorkItemRun.timeIntervalSinceNow > delay ? 0 : delay
        queue.asyncAfter(deadline: .now() + Double(delayTime), execute: workItem)
    }
    
}
