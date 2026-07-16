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

            SpeechPermission.request { granted in

                if granted {

                    self.recognizer.start()

                }
                
            }

        case "stop":
            recognizer.stop()

        default:
            break

        }

    }
}
