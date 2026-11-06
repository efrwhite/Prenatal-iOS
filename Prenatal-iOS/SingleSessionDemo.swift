//
//  SingleSessionDemo.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 11/3/26.
//
import SwiftUI

@main struct SingleSessionDemo: App {
    @State private var sessionState: SessionState!
    
    let session: Session?
    let error: String?
    
    init() {
        guard let sessionFileURL = Bundle.main.url(forResource: "session_1", withExtension: "json") else {
            session = nil
            error = "Failed to get session!"
            return
        }
        
        // Open the file into raw data
        // Not sure if mappedIfSafe is useful, frankly
        guard let fileContents = try? Data(contentsOf: sessionFileURL, options: .mappedIfSafe) else {
            session = nil
            error = "Failed to initialize Data of session!"
            return
        }
        // Docs show getting this into a let,
        // rather than doing a one-liner
        let decoder = JSONDecoder()
        // Decode the Session out of its source JSON
        session = try? decoder.decode(Session.self, from: fileContents)
        if session == nil {
            sessionState = nil
            error = "Failed to decode Data!"
        }
        else {
            sessionState = SessionState(session: session!)
            error = nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            // No logic in this demo besides showing our one session
            if session != nil {
                let unwrappedSession = session!
                if (!unwrappedSession.pages.isEmpty) {
                    SessionView()
                    // Assigns the session state into the nested environment for the session
                    // Force-unwrapped since it should only be nil if the session itself is nil
                        .environment(sessionState)
                }
                else {
                    // This shouldn't happen, but it technically could, so account for it
                    Text("Session has no pages!")
                }
            }
            else {
                Text(error ?? "Unable to parse session, but no error was provided!")
            }
        }
    }
}
