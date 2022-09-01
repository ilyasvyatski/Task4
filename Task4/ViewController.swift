//
//  ViewController.swift
//  Task4
//
//  Created by neoviso on 9/1/22.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let boxView: UIView = {
        let boxView = UIView()
        boxView.backgroundColor = .systemRed
        return boxView
    }()
    
    private let boxSize: CGFloat = 200

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBoxView()
        setupGestureRecognizers()
    }
    
    private func setupBoxView() {
        view.addSubview(boxView)
        boxView.frame = CGRect(x: 0, y: 0, width: boxSize, height: boxSize)
        boxView.center = view.center
    }
    
    private func setupGestureRecognizers() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotation(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        
        boxView.addGestureRecognizer(panGesture)
        boxView.addGestureRecognizer(rotationGesture)
        boxView.addGestureRecognizer(pinchGesture)
        
        panGesture.delegate = self
        rotationGesture.delegate = self
        pinchGesture.delegate = self
    }
    
    @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        guard let view = recognizer.view else { return }
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc private func didRotation(_ recognizer: UIRotationGestureRecognizer) {
        guard let view = recognizer.view else{return}
        view.transform = view.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }
    
    @objc private func didPinch(_ recognizer: UIPinchGestureRecognizer) {
        guard let view = recognizer.view else{return}
        view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

