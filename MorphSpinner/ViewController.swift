//
//  ViewController.swift
//  MorphSpinner
//
//  Created by Ruben Roques on 20/06/14.
//  Copyright (c) 2014 rrocks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var spinnerView = MorphSpinnerView()
    @IBOutlet var actionButton : UIButton

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNeedsStatusBarAppearanceUpdate()


        spinnerView = MorphSpinnerView(center: CGPointMake(self.view.center.x, self.view.center.y-40))
        spinnerView.color = UIColor.whiteColor()
        self.view.addSubview(spinnerView);

        spinnerView.start()
        actionButton.setTitle("Stop", forState: .Normal)
    }

    @IBAction func actionPressed(sender : UIButton) {
        if spinnerView.activated {
            spinnerView.stop()
            actionButton.setTitle("Start", forState: .Normal)
        }
        else{
            spinnerView.start()
            actionButton.setTitle("Stop", forState: .Normal)
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle{
        return .LightContent;
    }
}

