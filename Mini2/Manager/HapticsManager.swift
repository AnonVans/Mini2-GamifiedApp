//
//  HapticsManager.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 24/06/24.
//

import Foundation
import CoreHaptics
import AVFoundation

class HapticsManager {
    var engineRestart = false
    var engine: CHHapticEngine?
    var studyPlayer: CHHapticAdvancedPatternPlayer?
    var breakPlayer: CHHapticAdvancedPatternPlayer?
    
    init(engineRestart: Bool = false, engine: CHHapticEngine? = nil) {
        self.engineRestart = engineRestart
        self.engine = engine
        
        prepareHaptics()
    }
    
    private static var hapticMng: HapticsManager?
    
    static func getIntance() -> HapticsManager {
        if self.hapticMng == nil {
            self.hapticMng = HapticsManager()
        }
        return self.hapticMng!
    }
    
    func prepareHaptics() {
        guard
            CHHapticEngine.capabilitiesForHardware().supportsHaptics,
            CHHapticEngine.capabilitiesForHardware().supportsAudio
        else { return }
        
        if self.engine == nil {
            do {
                self.engine = try CHHapticEngine(audioSession: .sharedInstance())
            } catch {
                print("There was an error creating the engine: \(error.localizedDescription)")
            }
            
            self.engine?.stoppedHandler = { reason in
                print("The Engine Stopped due to \(reason.rawValue)")
                self.engineRestart = true
            }
            
            self.engine?.resetHandler = {
                print("The Engine Restarting now")
                self.engineRestart = true
            }
            
            do {
                try self.engine?.start()
            } catch {
                print("Failed in Starting the Engine: \(error.localizedDescription) ")
            }
        }
    }
    
    func restartEngineIfNeeded() {
        if engineRestart {
            do {
                try self.engine?.start()
            } catch {
                print("Failed in Starting the Engine: \(error.localizedDescription) ")
            }
            engineRestart = false
        }
    }
    
    func prepareAudio(_ audio: String) -> CHHapticAudioResourceID {
        let hapticSoundURL = Bundle.main.url(forResource: audio, withExtension: "wav")
        
        let hapticAudio = (try! engine?.registerAudioResource(hapticSoundURL!, options: [:]))!
        
        return hapticAudio
    }
    
    func prepareHapticsPattern(_ audioName: String) -> CHHapticAdvancedPatternPlayer? {
        prepareHaptics()
        restartEngineIfNeeded()
        
        var hapticsEvents = [CHHapticEvent]()
        var player: CHHapticAdvancedPatternPlayer?
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity,sharpness], relativeTime: 0, duration: 30)
        hapticsEvents.append(event)
        
        let audioEvent = CHHapticEvent(audioResourceID: prepareAudio(audioName), parameters: [CHHapticEventParameter(parameterID: .audioVolume, value: 1.0)], relativeTime: 0)
        hapticsEvents.append(audioEvent)
        
        do {
            let pattern = try CHHapticPattern(events: hapticsEvents, parameters: [])
            player = try self.engine?.makeAdvancedPlayer(with: pattern)
        } catch {
            print("Failed to make player: \(error.localizedDescription)")
        }
        
        return player
    }
    
    func playStudyHaptics() {
        restartEngineIfNeeded()
        
        self.studyPlayer = prepareHapticsPattern("CallOfDanger")
        
        do {
            try self.studyPlayer?.start(atTime: 0)
            self.studyPlayer?.loopEnabled = true
        } catch {
            print("Failed to play haptics: \(error.localizedDescription)")
        }
    }
    
    func playBreakHaptics() {
        restartEngineIfNeeded()
        
        self.breakPlayer = prepareHapticsPattern("CallOfGacha")
        
        do {
            try self.breakPlayer?.start(atTime: 0)
            self.breakPlayer?.loopEnabled = true
        } catch {
            print("Failed to play haptics: \(error.localizedDescription)")
        }
    }
    
    func stopStudyHaptics() {
        do {
            try self.studyPlayer?.stop(atTime: 0)
        } catch {
            print("Error in Stopping Haptics \(error.localizedDescription)")
        }
    }
    
    func stopBreakHaptics() {
        do {
            try self.breakPlayer?.stop(atTime: 0)
        } catch {
            print("Error in Stopping Haptics \(error.localizedDescription)")
        }
    }
}
