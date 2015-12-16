//
//  JLChatViewController.swift
//  JLChatViewController
//
//  Created by José Lucas Souza das Chagas on 28/11/15.
//  Copyright © 2015 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit


public class JLChatViewController: UIViewController {

    @IBOutlet public weak var chatTableView: ChatTableView!
    
    @IBOutlet public weak var toolBar: ChatToolBar!
    
    @IBOutlet public weak var toolBarDistToBottom: NSLayoutConstraint!
    
    @IBOutlet public weak var backButton: UIBarButtonItem!
    
    private var backButtonBlock:(()->())?
    
    override public func viewDidLoad() {
                
        super.viewDidLoad()
        
        self.registerKeyBoardNotifications()

    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated)
        
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Back button methods
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        if let backButtonBlock = backButtonBlock{
            backButtonBlock()
        }
        else{
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }

    }
    
    
    //MARK: - KeyBoard notifications
    
    func registerKeyBoardNotifications(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showkeyBoardTarget:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideKeyBoardTarget:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    func showkeyBoardTarget(notification:NSNotification){
        
        let info = notification.userInfo as! [String:AnyObject]
        
        let keyBoardFrame = info[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        
        let keyBoadHeight = keyBoardFrame!.height
        
        self.toolBarDistToBottom.constant = keyBoadHeight
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func hideKeyBoardTarget(notification:NSNotification){
        
        self.toolBarDistToBottom.constant = 0
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: Class func methods
    
       


}