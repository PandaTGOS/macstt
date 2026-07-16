//
//  EventWriter.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation

enum EventWriter {

    private static let encoder = JSONEncoder()

    static func write(_ event: SpeechEvent) {

        guard let data = try? encoder.encode(event) else {
            return
        }

        FileHandle.standardOutput.write(data)
        FileHandle.standardOutput.write(Data([0x0A]))
    }
}
