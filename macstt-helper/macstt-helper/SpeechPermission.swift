//
//  SpeechPermission.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation
import Speech

enum SpeechPermission {

    static func request(
        completion: @escaping (Bool) -> Void
    ) {

        SFSpeechRecognizer.requestAuthorization { status in

            DispatchQueue.main.async {

                completion(status == .authorized)

            }

        }

    }

}
