//
//  SessionView.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 9/21/26.
//
import SwiftUI
import Playgrounds

struct SessionView: View {
    // Constant for margin size, which is arbitrary (supposedly the default padding pre-iOS 27.1?)
    // Looks good to me, but may not be perfect overall
    static let margin = CGFloat(16)

    // Scales based on user-selected text size; can't be static (fails in runtime)
    // body used as the baseline arbitrarily here, but that sounds fine...?
    @ScaledMetric(relativeTo: .body) var scaledMargin = margin // Can't go in environment itself, sadly
    
    @Environment(SessionState.self) private var sessionState
    
    @State private var audioButtonText = "Listen"
    
    var body: some View {
        VStack {
            // The header, which consists of the title, progress bar, and navigation controls
            // The title
            Text(sessionState.session.title)
            // The progress bar
            HStack {
                Text("Session 1") // TODO This clearly can't stay hardcoded, but sessions aren't numbered
                ProgressView(value: sessionState.page.progress, total: 100.0)
                Spacer()
                Text((sessionState.page.progress / 100).formatted(.percent))
                    .frame(width: scaledMargin * 3, alignment: .trailing)
            }
            // The navigation buttons
            // Currently one omni-button with dividers, but will eventually be three separate ones
            HStack {
                // The "Back" button, which goes to the last-viewed page (like a browser back button)
                Button(action: sessionState.previousPage) {
                    Spacer()
                    Text("Back")
                    Spacer()
                }
                // TODO check if history is empty instead?
                .disabled(sessionState.page == sessionState.session.pages.first!)
                Divider().overlay(Color.gray).frame(width: 1)
                // The "Listen" button, which indicates to the session state to start playing audio
                // Not yet implemented properly, but likely to remain a function of the state itself
                Button(action: sessionState.listen) {
                    Spacer()
                    Text(sessionState.isListening ? "Pause" : "Listen")
                    Spacer()
                }
                Divider().overlay(Color.gray).frame(width: 1)
                // The "Exit" button, which saves any relevant state and leaves the session entirely
                // Currently functioning as a "reset" for initial demo purposes; ignore that
                Button(action: sessionState.reset) {
                    Spacer()
                    //Text("Exit")
                    Text("Reset")
                    Spacer()
                }
            }
            .frame(height: 40)
            .background(Rectangle().stroke(Color.gray))
            
            Spacer() // Divides header and body
            
            // The main page body, rendering any blocks that page has defined
            // I feel like this ideally should not need scrolling, but can we guarantee it?
            //ScrollView {
                VStack(alignment: .center, spacing: .zero) {
                    ForEach(sessionState.page.blocks) { block in
                        PageBlockView(block: block) // No way the contents of this are fitting inline here
                        Spacer().frame(height: scaledMargin) // Will be this height, not infinite
                    }
                }
            //}
            
            Spacer() // Divides body and footer
            
            // The footer, which currently only consists of what's dubbed the "Action Button"
            ActionButtonView(actionButton: sessionState.page.actionButton)
        }
        .modifier(ContainerMargins())
    }
}

// Defines the margins of the View, either per-device if on iOS 27.1+ or with a generic default figure
struct ContainerMargins: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 27.1, *) {
            content.contentMargins(for: .container, edges: .horizontal)
        } else {
            content.padding(.horizontal)
        }
    }
}
