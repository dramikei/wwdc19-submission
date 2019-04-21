import Foundation

//Stores the data for knowMoreViewController
struct KnowMoreData {
    let titles = ["What is Braille?", "About this app", "What all is used in this app?", "Credits"]
    
    let messages = ["Braille was a script made by Louis Braille.\nThe script has blocks called cells that have tiny bumps called raised dots. \nThe arrangement of these dots distinguish one character from another. \nBut unfortunately ever since flat screen phones became mainstream, \nblind have kind of been left out.\nPhones do have features like VoiceOver which read out whatever there is on the screen but it has its own short comings like: \n> The user cannot use voiceover in public places \n> the user cannot use earphones all the time. \nAnd therefore Blind face many difficulties while trying to read a book in their smartphones.", "When there is advancement in technology it benefits all of human kind, likewise this app tries to overcome the shortcomings of VoiceOver by making use of Braille script, HapticFeedback and alert sound. When a user encounters a dark circle (representing a raised dot) the app send out a hapticfeedback (if supported by the device) and a short audio alert to the user making it easy for the user to read the text on a flat screen phone.", "This app makes use of the following: \nCollectionViews \nCoreGraphics \nAnimations \nAVFoundation \nUIkit", "App makes use of a sound released under the \nAttribution 3.0 license by \nMike Koenig"]
}
