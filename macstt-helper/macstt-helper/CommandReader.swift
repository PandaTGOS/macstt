//
//  CommandReader.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation

final class CommandReader {

    var onCommand: ((Command) -> Void)?

    func start() {

        DispatchQueue.global().async {

            while let line = readLine() {

                guard
                    let data = line.data(using: .utf8),
                    let command = try? JSONDecoder().decode(Command.self, from: data)
                else {
                    print("Invalid JSON", to: &StandardError.output)
                    continue
                }

                DispatchQueue.main.async {
                    self.onCommand?(command)
                }
            }
        }
    }
}

struct StandardError: TextOutputStream {
    static var output = StandardError()

    mutating func write(_ string: String) {
        FileHandle.standardError.write(Data(string.utf8))
    }
}
