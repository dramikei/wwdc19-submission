import Foundation
import UIKit
import PlaygroundSupport
/*
 
 * Credits:
    "Braille Reader" makes use of an audio file which was downlaoded from Soundbible ( http://soundbible.com/1540-Computer-Error-Alert.html )
    released under Attribution 3.0 license by Mike Koenig.
 
 * About App:
    The app is made by Raghav Vashisht for WWDC19 Scholarship, The app is a proof of concept making use of Hapticfeedback and audio alerts which makes it possible to read Braille Script on a flatscreen device.
 
    The idea is that, the user would slide over the screen and when he encounters a reaised circle (represented by a dark circle in app) the app would send back a haptic and an audio alert, thus making is possible for the blind user to read the braille script.
 
    The app also integrates an English-to-Braille converter whose sole purpose was to keep the app dynamic and avoid using hard coded Braille script.
 
    Though nothing is perfect and so, the app has a few shortcomings:
    The user can only use one finger to read, as mutiple finger would lead to multiple alerts being generated which might cause confusion.
    This could be overcome if the device had more than one taptic engine and/or used different sounds for multiple finger inputs.
 
    This idea of being able to read brille could be used by the blinds to for example read ebooks on their smartphones or even tablets.
 
 * Technologies Used:
    The app makes use of simple to quite advanced technologies like:
        CoreGraaphics
        CollectionViews
        UIKit
        AVFoundation
        UIStackViews
        Animations
 
 * About Author:
    The playground is made by Raghav Vashisht 18 y/o High School student from India, currently preparing for entrance exams for universities.
 
 
 * About the Idea:
    The idea of this app struck to me when I was just lying on my bed and wondering how much smartphones have managed to help humanity
 
 * Reason for using CoreGraphics instead of using Images:
    CoreGraphics reduces loading time and has lower memory usage and keeps the app size minimum.
 
 
 Date: 23rd March 2019
*/


//Initialises startVC as a StartViewController
let startVC = StartViewController()

//Sets the size of the playground live view as the size of the startVC
startVC.preferredContentSize = CGSize(width: 768, height: 1024)

//Initialises navigationCOntroller as a UINavigationController with rootViewCOntroller as startVC
let navigationController = UINavigationController(rootViewController: startVC)

//sets navigation bar as hidden
navigationController.isNavigationBarHidden = true

//sets the playground liveView as the navigationController
PlaygroundPage.current.liveView = navigationController




