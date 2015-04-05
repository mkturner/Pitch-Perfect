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
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var filePathURL = NSURL(fileURLWithPath: filePath)
//                    } else {
//            println("empty filepath")
//        }
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        
        //create instance of AVAudioEngine, for sound processing
        audioEngine = AVAudioEngine()
        
        //convert NSURL to AVAudioFile for chipmunk function
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        println("started playing audio fastly")
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        // play audio slooowly here.
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        println("started playing audio slowly")
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        // use custom function to modify pitch
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        /*code reuse: using playAudioWithVariablePitch again,
            this time to lower pitch
        */
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        // stop any audioPlayer(s) or audioEngine(s) currently running
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        /* create object for AVAudioPlayerNode,
            attach to AVAudioEngine
        */
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        /* create object for AVAudioUnitTimePitch,
            use it to change pitch,
            attach it to AVAudioEngine
        */
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        //connect AVAudioPlayerNode to AVAudioUnitTimePitch
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        
        //connect AVAudioUnitTimePitch to Output
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        //play the audio
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        // stop playing audio
        audioPlayer.stop()
        println("stopped playing audio\n")
    }
    
}
