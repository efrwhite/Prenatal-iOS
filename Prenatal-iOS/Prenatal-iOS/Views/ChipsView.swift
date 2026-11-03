//
//  ChipsView.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/29/26.
//
import SwiftUI
import OrderedCollections
import Flow

struct ChipsView: View {
    
    @Environment(SessionState.self) private var sessionState
        
    let multiSelect: Bool
    let savedName: String
    let choices: [String]
    
    /*func resetSelections(blockState: ChipsState) {
        for choice in blockState.choices.keys {
            blockState.choices[choice] = false
        }
    }
    
    func onPressed(blockState: ChipsState, choice: String) {
        guard let wasSelected = blockState.choices[choice] else {
            // Shouldn't happen, but we're in an external func so let's make sure
            return
        }
        if wasSelected {
            blockState.choices[choice] = false
        }
        else {
            if !multiSelect {
                resetSelections(blockState: blockState)
            }
            blockState.choices[choice] = true
        }
    }*/
    
    var body: some View {
        InnerChipsView(multiSelect: multiSelect, blockState: sessionState.getChipsState(key: savedName, choices: choices))
        
        /*let blockState = sessionState.getChipsState(key: savedName, choices: choices)
        
        HFlow {
            ForEach (blockState.choices.keys, id: \.self) { choice in
                let isSelected = blockState.choices[choice]!
                let textColor = isSelected ? Color.white : Color.black
                let bgColor = isSelected ? Color.blue : Color.gray
                
                Button(action: { onPressed(blockState: blockState, choice: choice) }) {
                    Text(choice)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 40)
                        .foregroundStyle(textColor)
                        .background(RoundedRectangle(cornerRadius: 4).fill(bgColor))
                }
            }
        }*/
    }
}

private struct InnerChipsView: View {
    
    let multiSelect: Bool
    @State var blockState: ChipsState
    
    func resetSelections(blockState: ChipsState) {
        for choice in blockState.choices.keys {
            blockState.choices[choice] = false
        }
    }
    
    func onPressed(choice: String) {
        guard let wasSelected = blockState.choices[choice] else {
            // Shouldn't happen, but we're in an external func so let's make sure
            return
        }
        if wasSelected {
            blockState.choices[choice] = false
        }
        else {
            if !multiSelect {
                resetSelections(blockState: blockState)
            }
            blockState.choices[choice] = true
        }
    }

    var body: some View {
        HFlow {
            ForEach (blockState.choices.keys, id: \.self) { choice in
                let isSelected = blockState.choices[choice]!
                let textColor = isSelected ? Color.white : Color.black
                let bgColor = isSelected ? Color.blue : Color.gray
                
                Button(action: { onPressed(choice: choice) }) {
                    Text(choice)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(height: 40)
                        .foregroundStyle(textColor)
                        .background(RoundedRectangle(cornerRadius: 4).fill(bgColor))
                }
            }
        }
    }
}

extension SessionState {
    func getChipsState(key: String, choices: [String]) -> ChipsState {
        var chipsState = blockStates[key] as? ChipsState
        if (chipsState == nil) {
            chipsState = ChipsState(choices: choices)
            blockStates[key] = chipsState!
        }
        return chipsState!
    }
}
