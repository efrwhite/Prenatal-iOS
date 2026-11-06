//
//  SessionState.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/28/26.
//
import SwiftUI
import DequeModule

@Observable
class SessionState {
    
    let session: Session
    
    var page: SessionPage
    var blockStates: [String:PageBlockState] = [:]
    
    var isListening = false
    
    private var history: Deque<Int>
    
    init(session: Session) {
        self.session = session
        self.history = Deque(minimumCapacity: self.session.pages.count)
        page = self.session.pages.first!
    }
    
    // There's gotta be a better way to do this
    func reset() {
        page = session.pages.first!
        history.removeAll(keepingCapacity: true)
        blockStates.removeAll(keepingCapacity: true)
        isListening = false
    }
    
    func previousPage() {
        if let destination = history.popFirst() {
            page = session.pages[destination]
            isListening = false
        }
    }
    
    func skip() {
        // TODO this needs to do something and snapshotting the dict externally clearly isn't working...
        nextPage()
    }
    
    func nextPage() {
        goToPage(newPage: page.id + 1)
    }
    
    func goToPage(newPage: Int?) {
        if let newPageUnwrapped = newPage {
            goToPage(newPage: newPageUnwrapped)
        }
    }
    
    func goToPage(newPage: Int) {
        let newPageId = newPage - 1 // Pages are 1-indexed in the JSON
        if (newPageId < session.pages.count) {
            history.prepend(page.id - 1) // Assuming page number and index are correlated; should we?
            page = session.pages[newPageId] // Effective increment
            isListening = false
        }
    }
    
    // Dummy for demo purposes, not sure if this is really the play
    func listen() {
        isListening = !isListening
    }
    
}
