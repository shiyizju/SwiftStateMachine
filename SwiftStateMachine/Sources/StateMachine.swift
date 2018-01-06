//
//  StateMachine.swift
//
//  Created by XiaoshaQuan on 10/17/17.
//

import Foundation


public class StateMachine {
    
    private(set) var states: [String: SMState] = [:]
    private(set) var events: [String: SMEvent] = [:]
    
    public var initialState: SMState
    public var currentState: SMState?
    
    public init(states: [SMState], events: [SMEvent], initialState: SMState) {
        
        if states.contains(initialState) {
            self.initialState = initialState
        } else {
            self.initialState = states.first!
        }
        
        for state in states {
            self.states[state.name] = state
        }
        
        for event in events {
            
            // validate event
            for (srcState, dstState) in event.stateMap {
                if self.states[srcState.name] != srcState || self.states[dstState.name] != dstState {
                    assertionFailure()
                    break
                }
            }
            
            self.events[event.name] = event
        }
    }
    
    public func activate() {
        
        assert(!isActive)
        
        isActive = true
        
        // Dispatch callbacks to establish initial state
        initialState.willEnterStateBlock?(initialState, nil)
        currentState = self.initialState
        initialState.didEnterStateBlock?(initialState, nil)
    }
    
    public private(set) var isActive: Bool = false

    public func canFireEvent(name: String) -> Bool {
        
        guard let event = events[name] else {
            assertionFailure()
            return false
        }
        
        guard let currentState = currentState else {
            assertionFailure()
            return false
        }
        
        return event.stateMap[currentState] != nil
    }

    public func fireEvent(name: String, userInfo: [String: Any]) -> Bool {
        
        if !isActive {
            self.activate()
        }
        
        guard let event = events[name] else {
            assertionFailure()
            return false
        }
        
        guard let currentState = currentState else {
            assertionFailure()
            return false
        }
        
        // check that this transition is permitted
        guard let dstState = event.stateMap[currentState] else {
            assertionFailure()
            return false
        }
        
        let transition = SMTransition(event: event, srcState: currentState, dstState: dstState, stateMachine: self, userInfo: userInfo)
        
        if let block = event.shouldFireEventBlock, !block(event, transition) {
            // custom not fire event
            return false
        }
        
        let oldState = currentState
        let newState = dstState
        
        event.willFireEventBlock?(event, transition)
        
        oldState.willExitStateBlock?(oldState, transition)
        newState.willEnterStateBlock?(newState, transition)
        
        self.currentState = newState
        
        oldState.didExitStateBlock?(oldState, transition)
        newState.didEnterStateBlock?(newState, transition)
        
        event.didFireEventBlock?(event, transition)
        
        return true
    }
}
