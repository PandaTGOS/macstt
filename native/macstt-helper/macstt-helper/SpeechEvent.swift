//
//  SpeechEvent.swift
//  macstt-helper
//
//  Created by Sakhi Saswat Panda on 16/07/26.
//

import Foundation

struct SpeechEvent: Codable {
    let type: String
    let text: String
    let isFinal: Bool
    let timestamp: TimeInterval
}
