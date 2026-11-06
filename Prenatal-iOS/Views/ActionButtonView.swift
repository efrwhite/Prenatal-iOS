//
//  ActionButtonView.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/30/26.
//
import SwiftUI

struct ActionButtonView: View {
    
    @Environment(SessionState.self) private var sessionState
    
    let actionButton: ActionButton
    
    var body: some View {
        VStack {
            getButton()
            Text(actionButton.subscriptText ?? "") // TODO May be a nicer way to check for this?
        }
    }
    
    @ViewBuilder private func getButton() -> some View {
        switch actionButton.type {
        case .next:
            Button(action: sessionState.nextPage) {
                Self.singleButton(text: actionButton.text)
            }
        case .skipOrNext:
            HStack {
                Button(action: sessionState.skip) {
                    Self.singleButton(text: "Skip")
                }
                Button(action: sessionState.nextPage) {
                    Self.singleButton(text: actionButton.text)
                }
            }
        case .customOrNext:
            HStack {
                if (actionButton.customText != nil) {
                    Button(action: { sessionState.goToPage(newPage: actionButton.customDestination) }) {
                        Self.singleButton(text: actionButton.customText!)
                    }
                }
                Button(action: sessionState.nextPage) {
                    Self.singleButton(text: actionButton.text)
                }
            }
        case .custom:
            Button(action: { sessionState.goToPage(newPage: actionButton.destination) }) {
                Self.singleButton(text: actionButton.text)
            }
        case .finish:
            Button(action: sessionState.reset) {
                Self.singleButton(text: /*actionButton.text*/"Reset") // TODO change the text ofc
            }
        }
    }
    
    @ViewBuilder
    private static func singleButton(text: String) -> some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 40)
            .foregroundStyle(Color.black)
            .background(RoundedRectangle(cornerRadius: 4).fill(Color.blue))
    }
}
