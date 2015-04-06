//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marvin T. on 4/2/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
//        audioPlayer.enableRate = true
        
        //create instance of AVAudioEngine, for sound processing
        audioEngine = AVAudioEngine()
        
        //convert NSURL to AVAudioFile for chipmunk function
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithEffect(speed: 1.5)
        print(" fastly\n")
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // play audio slooowly here.
        playAudioWithEffect(speed: 0.5)
        print(" slowly\n")
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        // use custom function to modify pitch
        playAudioWithEffect(pitch: 1000)
        println("chipmunk")
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        /*code reuse: using playAudioWithVariablePitch again,
            this time to lower pitch
        */
        playAudioWithEffect(pitch: -1000)
        println("vader")
    }
    
    @IBAction func playWithEcho(sender: UIButton) {
        playAudioWithEffect(echo: true)
        println("echo")
    }
    
    @IBAction func playWithReverb(sender: UIButton) {
        playAudioWithEffect(reverb: true)
        println("reverb")
    }
    
    func playAudioWithEffect(pitch: Float = 1.0, speed: Float = 1.0, echo: Bool = false, reverb: Bool = false) {
        // stop any audioPlayer(s) or audioEngine(s) currently running
        prepareAudioEngine()
        
        /* create object for AVAudioPlayerNode,
            attach to AVAudioEngine
        */
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        /* create object for AVAudioUnitTimePitch,
            use it to change pitch or speed,
            attach it to AVAudioEngine
        */
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        changePitchEffect.rate = speed
        audioEngine.attachNode(changePitchEffect)
        
        /*create Objects for AVAudioUnitDistortion (for Echo) 
            & AVAudioUnitReverb (for Reverb)
        */
        var distortEffect = AVAudioUnitDistortion()
        distortEffect.loadFactoryPreset(AVAudioUnitDistortionPreset.MultiEcho1)
        audioEngine.attachNode(distortEffect)
        
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.SmallRoom)
        reverbEffect.wetDryMix = 33.3
        audioEngine.attachNode(reverbEffect)
    
        if (echo) {
            // Connect AVAudioUnitDistortion
            //connect AVAudioPlayerNode to AVAudioUnitDistortion
            audioEngine.connect(audioPlayerNode, to: distortEffect, format: nil)
            
            //connect AVAudioUnitTimePitch to Output
            audioEngine.connect(distortEffect, to: audioEngine.outputNode, format: nil)

        } else if (reverb) {
            // Connect AVAudioUnitReverb
            //connect AVAudioPlayerNode to AVAudioUnitTimePitch
            audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
            
            //connect AVAudioUnitTimePitch to Output
            audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)

        } else {
        
            //connect AVAudioPlayerNode to AVAudioUnitTimePitch
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            
            //connect AVAudioUnitTimePitch to Output
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        }
        
        //play the audio
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }

    func prepareAudioEngine(){
        /*prepare audio engine for playback,
            avoid overlapping of payback effects
        */
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        // stop playing audio
        prepareAudioEngine()
        println("stopped playing audio\n")
    }
    
}
