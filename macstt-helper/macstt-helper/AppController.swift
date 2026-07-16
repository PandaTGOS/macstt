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

            switch command.cmd {

            case "start":

                SpeechPermission.request { granted in

                    let event = SpeechEvent(
                        text: granted
                            ? "Speech authorized"
                            : "Speech denied",
                        isFinal: true,
                        timestamp: Date().timeIntervalSince1970
                    )

                    EventWriter.write(event)

                }

            default:
                break
                
            }
        }

        reader.start()
    }
}
