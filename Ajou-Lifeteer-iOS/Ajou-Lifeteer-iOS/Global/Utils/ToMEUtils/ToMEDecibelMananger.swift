//
//  ToMEDecibelMananger.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/7/23.
//

import Foundation
import AVFoundation
import UIKit

class ToMEDecibelMananger: NSObject, AVAudioRecorderDelegate {
    
    // MARK: - Properties

    var audioRecorder: AVAudioRecorder!
    var levelTimer: Timer?
    
    // MARK: - Initalizer
    
    override init() {
        super.init()
        requestAudioAuthorization()
    }
    
    // MARK: - Methods
    
    // 오디오 접근 권한 확인 및 처리
    func requestAudioAuthorization() {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            if granted {
                print("권한 허용")
                self.setupAudioSession()
            } else {
                print("권한 거부")
            }
        }
    }

    // audio 세팅
    func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setActive(true)
        } catch {
            print("Audio session setup error: \(error.localizedDescription)")
        }
    }
    
    func recordNotAllowed() {
        print("permission denied")
    }
    
    // 데시벨 모니터링
    func startMonitoringDecibels() {
        let audioSession = AVAudioSession.sharedInstance()
        
        let settings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderBitRateKey: 128,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ] as [String: Any]
        
        do {        
            audioRecorder = try AVAudioRecorder(url: URL(fileURLWithPath: "/dev/null"), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("Audio recorder setup error: \(error.localizedDescription)")
        }
        
        levelTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateAudioLevel), userInfo: nil, repeats: true)
    }
    
    // 오디오 레벨 업데이트
    @objc func updateAudioLevel() {
        audioRecorder.updateMeters()
        var decibels = audioRecorder.peakPower(forChannel: 0)
        
        print("데시벨 레벨: \(decibels + 20)")
    }
    
    // (화면을 빠져나갈 경우) 데시벨 모니터링 중단
    func stopMonitoringDecibels() {
        levelTimer?.invalidate()
        audioRecorder?.stop()
    }
}
