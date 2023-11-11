//
//  ToMEMusicManager.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 11/12/23.
//

import AVFoundation

class ToMEMusicManager {
    
    // MARK: - Properties
    
    static let shared = ToMEMusicManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Methods
    
    /// 음악 재생
    func playMusic(withTitle title: String, loop: Int) {
        guard let musicURL = Bundle.main.url(forResource: title, withExtension: "mp3") else {
            print("Music file not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
            audioPlayer?.numberOfLoops = loop
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing music: \(error.localizedDescription)")
        }
    }
    
    /// 정해진 시간 동안만 재생하고 싶은 경우
    func playMusicWithTimeInterval(forTitle title: String, duration: TimeInterval) {
        if let path = Bundle.main.path(forResource: title, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()

                Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                    self?.stopMusic(withTitle: title)
                }
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }
    
    /// 음악 멈추기
    func stopMusic(withTitle title: String) {
        if let audioPlayer = audioPlayer, let currentTitle = audioPlayer.url?.lastPathComponent, currentTitle == "\(title).mp3" {
            audioPlayer.stop()
        }
    }
}
