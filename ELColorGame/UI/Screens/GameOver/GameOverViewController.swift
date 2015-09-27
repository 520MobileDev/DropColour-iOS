//
//  GameOverViewController.swift
//  ELColorGame
//
//  Created by Mateusz Szklarek on 26/09/15.
//  Copyright © 2015 EL Passion. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    var blurEffectView: UIVisualEffectView = UIVisualEffectView(frame: CGRectZero)
    let scoreTextLabel = UILabel(frame: CGRectZero)
    var scoreNumber: Int = Int()
    let cancelButton = Button(title: "CANCEL", color: UIColor(red:0.91, green:0.15, blue:0.33, alpha:1))
    let tryAgainButton = Button(title: "TRY AGAIN", color: UIColor(red:0.38, green:0.87, blue:0.1, alpha:1))
    
    init(score: Int) {
        super.init(nibName: nil, bundle: nil)
        self.scoreNumber = score
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        configureBlurEffectView()
        configureScoreTextLabel()
        configureCancelButton()
        configureTryAgainButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configureGestureRecognizer(self.view)
    }
    
    //Subviews
    
    func configureBlurEffectView () {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.contentView.backgroundColor = UIColor.clearColor()
        setupBlurEffectViewLayout()
    }
    
    func configureScoreTextLabel() {
        scoreTextLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        scoreTextLabel.numberOfLines = 2
        scoreTextLabel.textAlignment = NSTextAlignment.Center
        scoreTextLabel.text = "YOUR SCORE\n\(scoreNumber)"
        scoreTextLabel.font = UIFont(name: BebasNeueBold, size: 30)
        scoreTextLabel.textColor = UIColor(red:1, green:1, blue:1, alpha:1)
        setupScoreTextLabelLayout()
    }
    
    func configureCancelButton() {
        cancelButton.buttonActionClosure = { [weak self] in
            self?.dismissGameOverViewController()
        }
        setupCancelButtonLayout()
    }
    
    func configureTryAgainButton() {
        tryAgainButton.buttonActionClosure = { [weak self] in
            self?.didTapOnTryAgainButton()
        }
        setupTryAgainButtonLayout()
    }

    //Action methods
    
    func dismissGameOverViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didTapOnTryAgainButton() {
        let gameBoardViewController = GameBoardViewController()
        presentViewController(gameBoardViewController, animated: true, completion: nil)
    }
    
    func configureGestureRecognizer(myView: UIView) {
        myView.userInteractionEnabled = true
        myView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dismissGameOverViewController")))
    }
    
    //Layout
    
    func setupBlurEffectViewLayout() {
        self.view.addSubview(blurEffectView)
        blurEffectView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
    }
    
    func setupScoreTextLabelLayout() {
        self.view.addSubview(scoreTextLabel)
        scoreTextLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
        }
    }
    
    func setupCancelButtonLayout() {
        self.view.addSubview(cancelButton)
        cancelButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(scoreTextLabel.snp_bottom).offset(30)
            make.width.equalTo(170)
            make.height.equalTo(55)
            make.centerX.equalTo(0)
        }
    }
    
    func setupTryAgainButtonLayout() {
        self.view.addSubview(tryAgainButton)
        tryAgainButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cancelButton.snp_bottom).offset(30)
            make.width.equalTo(170)
            make.height.equalTo(55)
            make.centerX.equalTo(0)
        }
    }
}
