//
//  SMTransition.swift
//
//  Created by XiaoshaQuan on 10/17/17.
//

import Foundation


public class SMTransition {
    
    public var event: SMEvent
    public var srcState: SMState
    public var dstState: SMState
    public var stateMachine: StateMachine
    public var userInfo: [String: Any]
    
    public init(event: SMEvent, srcState: SMState, dstState: SMState, stateMachine: StateMachine, userInfo: [String: Any]) {
        self.event = event
        self.srcState = srcState
        self.dstState = dstState
        self.stateMachine = stateMachine
        self.userInfo = userInfo
    }
    
}

