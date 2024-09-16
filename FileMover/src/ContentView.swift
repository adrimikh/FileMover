//
//  ContentView.swift
//  DocumentTry
//
//  Created by adi on 16.09.2024.
//

import SwiftUI

//TODO: Dynamic Extension Possibility, create a new panel that adds a new extension
//TODO: Treat JPEG as JPG

import SwiftUI

struct ContentView: View {
    public let extensions = ["jpg", "pdf", "txt", "doc", "docx", "png", "mp3", "mp4", "zip", "Custom File Extension"]
    @State private var selectedExtension = "jpg"
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "doc.circle")
                    .symbolRenderingMode(.hierarchical)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(.red)
                
                Text("FileMover")
                    .font(.system(size: 35))
                    .bold()
            }
            .padding()
            
            Picker("Choose an extension", selection: $selectedExtension) {
                ForEach(extensions, id: \.self) { ext in
                    Text("\(ext)")
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            HStack {
                CustomButton(symbolName: "doc.on.doc", removeFiles: false, selectedExtension: selectedExtension)
                CustomButton(symbolName: "arrow.up.doc", removeFiles: true, selectedExtension: selectedExtension)
            }
        }
    }

}

@main
struct FileMoverApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .navigationTitle("FileMover")
        }
    }
}

struct CustomButton: View {
    let symbolName: String
    let removeFiles: Bool
    let selectedExtension: String
    
    var body: some View {
        Button {
            moveOrCopyFiles(remove: removeFiles, chosenExtension: selectedExtension)
        }
        label: {
            Image(systemName: symbolName)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
                .frame(width: 40, height: 40)
        }
        .frame(width: 40, height: 40)
        .padding()
    }
}

#Preview {
    ContentView()
}
