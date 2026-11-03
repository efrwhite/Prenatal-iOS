//
//  PageBlockView.swift
//  Prenatal-iOS
//
//  Created by Naomi Morse on 10/29/26.
//
import SwiftUI

struct PageBlockView: View {
        
    let block: PageBlock
    
    var body: some View {
        switch block {
        case let .text(data):
            Text(Self.parseMarkdown(data))
            // If this isn't set, line wrap will occur but only the first line will be centered
                .multilineTextAlignment(.center)
        case let .title(data):
            Text(Self.parseMarkdown(data))
            // If this isn't set, line wrap will occur but only the first line will be centered
                .multilineTextAlignment(.center)
            // This could be a modifier on Text above, frankly,
            // but it feels notable as its own item logically
                .font(.title)
        case let .image(name):
            // This code works perfectly fine, but it takes infinite height if the image cannot be found
            // Given no images are currently present, it's commented out for visibility
            /*Image(name)
            // Image has to be resizable, even if with no args, to
            // allow it to be made to fit the screen
                .resizable()
            // Not specifying a ratio keeps the original one, but
            // we do need to use this to specify fitting to ratio
            // rather than filling and disregarding it
                .aspectRatio(contentMode: .fit)*/
            Text("TODO impement Image (" + name + ")").bold()
        case .horizontalRule:
            Divider()
        case .list:
            ListView(elements: block.flattened)
        case let .boxedText(background, data):
            Text("TODO implement BoxedText").bold()
        case let .chips(multiSelect, savedName, choices):
            ChipsView(multiSelect: multiSelect, savedName: savedName, choices: choices)
        case let .accordion(placeAt, choices):
            Text("TODO implement Accordion").bold()
        case let .input(size, savedName, watermark):
            Text("TODO implement Input").bold()
        case let .navigationButton(text, destination):
            Text("TODO implement NavigationButton").bold()
        case let .showIfSaved(check, elements):
            Text("TODO implement ShowIfSaved").bold()
        }
    }

    // Ensures a passed String is parsed for any Markdown
    // Feels this may be slightly redundant, but I did have to re-add this to work...?
    private static func parseMarkdown(_ inString: String) -> AttributedString {
        do {
            return try AttributedString(
                markdown:inString)
        } catch {
            // Default error message from docs
            return AttributedString("Couldn't parse the string. \(error.localizedDescription)")
        }
        
    }
}
