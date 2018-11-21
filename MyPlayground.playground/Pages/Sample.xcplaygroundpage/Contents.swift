//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"
str

initialize()
let controller = UIViewController()

// Set the device type and orientation.
let (parent, _) = playgroundControllers(device: .phone4inch, orientation: .portrait, child: controller)

// Render the screen.
let frame = parent.view.frame
PlaygroundPage.current.liveView = parent
parent.view.frame = frame

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
button.backgroundColor = .red

controller.view.addSubview(button)
