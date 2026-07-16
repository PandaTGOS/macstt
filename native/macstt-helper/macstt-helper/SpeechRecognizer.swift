//
//  SpeechRecognizer.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation
import AVFoundation
import Speech

final class SpeechRecognizer {

    private let engine = AVAudioEngine()

    private let recognizer =
        SFSpeechRecognizer(
            locale: Locale(identifier: "en-US")
        )

    private var request: SFSpeechAudioBufferRecognitionRequest?

    private var task: SFSpeechRecognitionTask?

    private var running = false

    var isRunning: Bool {
        running
    }

    var onEvent: ((SpeechEvent) -> Void)?

    func start() {

        guard !running else {
            return
        }

        running = true

        request = SFSpeechAudioBufferRecognitionRequest()

        guard
            let request,
            let recognizer
        else {
            running = false
            return
        }

        request.shouldReportPartialResults = true
        request.requiresOnDeviceRecognition = true

        let input = engine.inputNode
        let format = input.outputFormat(forBus: 0)

        input.installTap(
            onBus: 0,
            bufferSize: 256,
            format: format
        ) { buffer, _ in
            request.append(buffer)
        }

        engine.prepare()

        do {
            try engine.start()
        } catch {
            running = false
            return
        }

        task = recognizer.recognitionTask(
            with: request
        ) { [weak self] result, error in

            guard
                let self,
                let result
            else {
                return
            }

            if error != nil {
                return
            }

            self.onEvent?(

                SpeechEvent(
                    type: "speech",
                    text: result.bestTranscription.formattedString,
                    isFinal: result.isFinal,
                    timestamp: Date().timeIntervalSince1970
                )

            )

        }

    }

    func stop() {

        guard running else {
            return
        }

        running = false
        
        engine.stop()

        engine.inputNode.removeTap(onBus: 0)

        request?.endAudio()

        task?.cancel()

        request = nil

        task = nil

    }

}
