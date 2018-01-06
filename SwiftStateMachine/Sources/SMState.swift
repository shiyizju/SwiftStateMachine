//
//  SMState.swift
//  Meipu
//
//  Created by XiaoshaQuan on 10/17/17.
//

import Foundation


public class SMState: Hashable {
    
    public let name: String
    
    public var willEnterStateBlock: ( (SMState, SMTransition?) -> Void )?
    public var didEnterStateBlock: ( (SMState, SMTransition?) -> Void )?
    public var willExitStateBlock: ( (SMState, SMTransition?) -> Void )?
    public var didExitStateBlock: ( (SMState, SMTransition?) -> Void )?
    
    public var hashValue: Int {
        return name.hashValue
    }
    
    public init(name: String) {
        self.name = name
    }
}

public func ==(left: SMState, right: SMState) -> Bool {
    return left.name == right.name
}
