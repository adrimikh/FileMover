//
//  Logic.swift
//  DocumentTry
//
//  Created by adi on 16.09.2024.
//

import Foundation
import Cocoa

let fm = FileManager.default

private func chooseBeginningPath() -> URL {
    let openPanel = NSOpenPanel()
    
    openPanel.canChooseFiles = false
    openPanel.canChooseDirectories = true
    openPanel.allowsMultipleSelection = false
    openPanel.prompt = "Choose beginning path"
    
    if openPanel.runModal() == .OK {
        return openPanel.url!
    }else{
        return URL(fileURLWithPath: "")
    }
}

private func chooseTargetPath() -> URL {
    let openPanel = NSOpenPanel()
    
    openPanel.canChooseFiles = false
    openPanel.canChooseDirectories = true
    openPanel.allowsMultipleSelection = false
    openPanel.prompt = "Choose target path"
    
    if openPanel.runModal() == .OK {
        return openPanel.url!
    }else{
        return URL(fileURLWithPath: "")
    }

}

private func createFolder() -> URL{
    let targetPath = chooseTargetPath()
    
    do {
        try fm.createDirectory(at: targetPath.appending(path: "Extensions"), withIntermediateDirectories: true)
        return targetPath.appending(path: "Extensions")
    }catch{
        print(error.localizedDescription)
    }
    return URL(fileURLWithPath: "")
}

private func detectAllCandidates(begPath: URL, ext: String) -> [URL] {
    var files = [URL]()
    
    do {
        let potentialFiles = try fm.contentsOfDirectory(atPath: begPath.path(percentEncoded: true))
        
        for file in potentialFiles {
            var fileExtension = ""
            let reversedFileName = file.reversed()
                        
            for char in reversedFileName {
                if (char != ".") {
                    fileExtension.append(char)
                }else{
                    break
                }
            }
            
            if (String(fileExtension.reversed()) == ext) {
                if let url = URL(string: file) {
                    files.append(url)
                }else{
                    print("Invalid URL")
                }
            }
        }
    }catch {
        print("\(error.localizedDescription)")
    }
    
    return files
}

func moveOrCopyFiles(remove: Bool, chosenExtension: String) {
    let beginningPath = chooseBeginningPath()
    let filesToMove = detectAllCandidates(begPath: beginningPath, ext: chosenExtension)
    let targetPath = createFolder()
    
    /*
    if(filesToMove.isEmpty) {
        openNewWindow()
        return
    }
     */
    
    for f in filesToMove {
        let fullPath = beginningPath.appending(path: f.path())
        
        do {
            let fileData = try Data(contentsOf: fullPath)
            
            try fileData.write(to: targetPath.appending(path: f.path()))
            
            if (remove) {
                do {
                    try fm.removeItem(at: beginningPath.appending(path: f.path()))
                }catch {
                    print(error.localizedDescription)
                }
            }
                
        }catch {
            print(error.localizedDescription)
        }
         
    }
}








