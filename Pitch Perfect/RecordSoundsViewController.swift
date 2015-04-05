//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Marvin T. on 4/1/15.
//  Copyright (c) 2015 Marvin Turner. All rights reserved.
//

//import necessary frameworks
import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    //declare some outlets to use for manipulating the app
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    //create object for the
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Enter code to be run RIGHT before view appears (show/hide)
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        // TODO: Show text "recording in progress"
        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        // print info to console, tell what's happening
        println("in recordAudio")
        
        // TODO: Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        /* Use current Date-Time to format a file name for the recording
            should be unique identifier.
        Combine dirPath and recordingName to get complete filePath.
        Print filePath to console to verify.
        */
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        // Create a recording session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // Final setup, begin recording
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }

    @IBAction func doneRecording(sender: UIButton) {
        // TODO: Hide "recording in progress"
        recordingInProgress.hidden = true
        recordButton.enabled = true
        // TODO: Stop Recording
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        println("done recording\n")
    }
}

