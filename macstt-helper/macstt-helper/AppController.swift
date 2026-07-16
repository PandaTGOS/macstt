//
//  AppController.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation

final class AppController {

    private let reader = CommandReader()

    func start() {

        reader.onCommand = { command in

            let event = SpeechEvent(
                text: command.cmd.capitalized,
                isFinal: true,
                timestamp: Date().timeIntervalSince1970
            )

            EventWriter.write(event)
        }

        reader.start()
    }
}
