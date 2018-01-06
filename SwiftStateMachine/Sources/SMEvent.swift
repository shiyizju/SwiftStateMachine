//
//  SMEvent.swift
//
//  Created by XiaoshaQuan on 10/17/17.
//

import Foundation


public class SMEvent: Hashable {
    
    public let name: String
    public let stateMap: [SMState: SMState]
    
    public init(name: String, stateMap: [SMState: SMState]) {
        self.name = name
        self.stateMap = stateMap
    }
    
    public var hashValue: Int {
        return name.hashValue
    }
    
    public var shouldFireEventBlock: ( (SMEvent, SMTransition) -> Bool )?
    public var willFireEventBlock: ( (SMEvent, SMTransition) -> Void )?
    public var didFireEventBlock: ( (SMEvent, SMTransition) -> Void )?
}

public func ==(left: SMEvent, right: SMEvent) -> Bool {
    return left.name == right.name
}
