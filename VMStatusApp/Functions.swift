//  Created by petera on 2/5/23.
import Foundation
import SwiftUI
import Cocoa

@discardableResult
func safeShell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.arguments = ["--login","-c", command]
    task.standardInput = nil
    try task.run()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    print(output)
    return output
}

func executeAsyncCommand(at Path: String, completion: @escaping (String?) -> Void) {
    var result = "default"
    do {
        result = try safeShell("whoami")
    } catch {
        result = "YOU FUCKED YOURSELF"
    }
    
    completion(result)
}
