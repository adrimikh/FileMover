//
//  NoFilesFoundAlertView.swift
//  DocumentTry
//
//  Created by adi on 16.09.2024.
//

import SwiftUI

struct NoFilesFoundAlertView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.yellow)
                .symbolRenderingMode(.monochrome)
                .padding()
            
            Text("No files containing the extension you chose were found!")
                .padding()
            
            Button(action: {}) {
                Text("OK")
                    .padding()
                    .foregroundColor(.blue)
                    .background(.white)
            }
            .padding()
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    NoFilesFoundAlertView()
}

