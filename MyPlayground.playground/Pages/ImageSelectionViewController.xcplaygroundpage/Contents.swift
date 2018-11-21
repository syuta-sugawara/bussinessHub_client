import UIKit
import PlaygroundSupport
@testable import Rswift
@testable import Library

var str = "Hello, playground"

initialize()
var controller: UIViewController = R.storyboard.imageSelectionViewController.instantiateInitialVC()
// Set the device type and orientation.
let (parent, _) = playgroundControllers(device: .phone4inch, orientation: .portrait, child: controller)

// Render the screen.
let frame = parent.view.frame
PlaygroundPage.current.liveView = parent
parent.view.frame = frame
