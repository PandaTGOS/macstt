//
//  AppController.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation

final class AppController {

    private let reader = CommandReader()

    private let recognizer = SpeechRecognizer()

    func start() {

        recognizer.onEvent = {
            EventWriter.write($0)
        }

        reader.onCommand = { [weak self] command in
            self?.handle(command)
        }

        reader.start()

    }

    private func handle(_ command: Command) {

        switch command.cmd {

        case "start":

            guard !recognizer.isRunning else {
                return
            }

            SpeechPermission.request { granted in

                guard granted else {
                    return
                }

                EventWriter.write(

                    StatusEvent(
                        type: "started",
                        timestamp: Date().timeIntervalSince1970
                    )

                )

                self.recognizer.start()

            }

        case "stop":
            
            guard recognizer.isRunning else {
                return
            }

            recognizer.stop()

            EventWriter.write(
                StatusEvent(
                    type: "stopped",
                    timestamp: Date().timeIntervalSince1970
                )
            )

        default:
            break

        }
    }
}
