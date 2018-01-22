//
//  JLTextMessageCell.swift
//  ChatViewController
//
//  Created by José Lucas Souza das Chagas on 29/11/15.
//  Copyright © 2015 José Lucas Souza das Chagas. All rights reserved.
//

import UIKit


//https://www.captechconsulting.com/blogs/performance-tuning-on-older-ios-devices

//https://yalantis.com/blog/mastering-uikit-performance/


open class JLTextMessageCell: JLChatMessageCell {
    
    
    @IBOutlet public weak var chatTextView: JLChatTextView!
    
    @IBOutlet public weak var senderImageView: UIImageView!
    
    @IBOutlet weak var errorToSendButton: UIButton!
    

    @IBOutlet public weak var chatMessageLabel: JLChatLabel!
    // --- ---- ----- constraints
    
    
    @IBOutlet weak var errorToSendLeadingDist: NSLayoutConstraint!
    
    
    
    //senderImage contraints - start
    /**
     This is a constraint of 'senderImageView' do not change its value manually.
     
     Changes on it are made by 'JLChatAppearance'
     */

    @IBOutlet weak var senderImageHeight: NSLayoutConstraint!
    /**
     This is a constraint of 'senderImageView' do not change its value manually.
     
     Changes on it are made by 'JLChatAppearance'
     */
    @IBOutlet weak var senderImageWidth: NSLayoutConstraint!
        
    @IBOutlet weak var imageDistToSide: NSLayoutConstraint!
    //senderImage contraints - end
    
    //for know its being used because its seems that some last bug is resolved using a better way
    @IBOutlet weak var bubbleMinWidth: NSLayoutConstraint!
    @IBOutlet weak var bubbleMinHeight: NSLayoutConstraint!
    
    /**
     This a constraint used for aligment between sender`s image and bubble
     */
    @IBOutlet weak var senderImageBottomToBubbleBottom: NSLayoutConstraint!
    /**
     This a constraint used for aligment between sender`s image and bubble
     */
    @IBOutlet weak var senderImageToBubble: NSLayoutConstraint!
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        // Initialization code
    }
    
    override open func prepareForReuse() {
        //senderImageView.image = nil
        hideErrorButton(animated: false)

    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    open override func initCell(message: JLMessage, thisIsNewMessage: Bool, isOutgoingMessage: Bool) {
        super.initCell(message: message, thisIsNewMessage: thisIsNewMessage, isOutgoingMessage: isOutgoingMessage)
        
        //If it is being reused do not configure these things again
        if cellAlreadyUsed == false{
            
            //self.transform = CGAffineTransformMakeScale(1, -1)//CGAffineTransformInvert(self.transform)
            
            self.chatMessageLabel.font = JLChatAppearence.chatFont
            
            self.errorToSendButton.setImage(JLChatAppearence.normalStateErrorButtonImage, for: [])
            self.errorToSendButton.setImage(JLChatAppearence.selectedStateErrorButtonImage, for: UIControlState.selected)
            
            
            if isOutgoingMessage{
               //bubbleMinWidth.constant = JLChatAppearence.outgoingBubbleImage!.size.width
                //bubbleMinHeight.constant = JLChatAppearence.outgoingBubbleImage!.size.height
                
                configAsOutgoingMessage()
            }
            else{
                //bubbleMinWidth.constant = JLChatAppearence.incomingBubbleImage!.size.width
                //bubbleMinHeight.constant = JLChatAppearence.incomingBubbleImage!.size.height
                
                configAsIncomingMessage()
            }
            
            cellAlreadyUsed = true
            
        }
        
        
        
        self.chatMessageLabel.text = message.text
        //self.chatMessageLabel.settAttributedText(message.text)

        senderImageView.image = message.senderImage
        
        if message.messageStatus == MessageSendStatus.ErrorToSend{
            showErrorButton(animated: false)
        }

    }
    
      
    
    override open func updateMessageStatus(message:JLMessage){
        
        super.updateMessageStatus(message: message)
        
        if message.messageStatus == MessageSendStatus.ErrorToSend{
            self.showErrorButton(animated: true)
        }
        else{
            self.hideErrorButton(animated: true)
        }
        
        
    }
    
    //MARK: - Alert error button methods
    
    override open func showErrorButton(animated:Bool){
        
        super.showErrorButton(animated: animated)
        
        self.errorToSendLeadingDist.constant = 5
        
        if animated{
            
            UIView.animate(withDuration: 0.4) { () -> Void in
                self.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.errorToSendButton.alpha = 1
                
                }, completion: nil)
            
        }
        else{
            self.errorToSendButton.alpha = 1
            self.layoutIfNeeded()
        }
       
       
    }
    
     override open func hideErrorButton(animated:Bool){
        
        super.hideErrorButton(animated: animated)
        
        self.errorToSendLeadingDist.constant = -35
        
        if animated{
            
            UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.errorToSendButton.alpha = 0
                
                }, completion: nil)
            
            UIView.animate(withDuration: 0.4, delay: 0.4, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.layoutIfNeeded()
                
                }, completion: nil)


        }
        else{
            self.errorToSendButton.alpha = 0
            self.layoutIfNeeded()
        }

        
    }
    
    
    //MARK: - Menu methods
    @IBAction func errorButtonAction(_ sender: AnyObject) {
        
        showMenu()
    }
    
    override open func configMenu(deleteTitle:String?,sendTitle:String?,deleteBlock:@escaping ()->(),sendBlock:@escaping ()->()){
        
        if !isMenuConfigured{
            addLongPress()
        }
        
        super.configMenu(deleteTitle: deleteTitle, sendTitle: sendTitle, deleteBlock: deleteBlock, sendBlock: sendBlock)

        
        

    }
    
    private func addLongPress(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action:#selector(JLTextMessageCell.longPressAction(_:)))
            
        self.chatMessageLabel.addGestureRecognizer(longPress)
    }
    
    
    @objc func longPressAction(_ longPress:UILongPressGestureRecognizer){
        
        if longPress.state == UIGestureRecognizerState.began{
            
            self.chatMessageLabel.alpha = 0.5
        }
        else if longPress.state == UIGestureRecognizerState.ended{
            
            self.showMenu()
            
        }
        else if longPress.state == UIGestureRecognizerState.cancelled || longPress.state == UIGestureRecognizerState.failed{
            self.chatMessageLabel.alpha = 1
        }
        
    }
    
    
    func showMenu(){
        self.becomeFirstResponder()
        
        self.chatMessageLabel.alpha = 1
        
        let targetRectangle = self.chatMessageLabel.frame
        
        UIMenuController.shared.setTargetRect(targetRectangle, in: self)
                
        UIMenuController.shared.setMenuVisible(true, animated: true)
        

    }
    
    
    
    //MARK: - Config methods
    open override func configAsOutgoingMessage(){
        if JLChatAppearence.showOutgoingSenderImage{
            self.senderImageView.backgroundColor = JLChatAppearence.senderImageBackgroundColor
            
            self.senderImageView.image = JLChatAppearence.senderImageDefaultImage
            
            self.senderImageHeight.constant = JLChatAppearence.senderImageSize.height
            
            self.senderImageWidth.constant = JLChatAppearence.senderImageSize.width
            
            self.senderImageView.layer.cornerRadius = JLChatAppearence.senderImageCornerRadius
            
            
            //config the changes only if needs to show the sender image
            senderImageBottomToBubbleBottom.constant = JLChatAppearence.vertivalDistBetweenImgBottom_And_BubbleBottom
            senderImageToBubble.constant = JLChatAppearence.horizontalDistBetweenImg_And_Bubble
            
        }
        else{
            senderImageToBubble.constant = 5
            imageDistToSide.constant = -30
            
            //self.senderImageHeight.constant = 0
            
            //self.senderImageWidth.constant = 0
        }
        
        self.chatMessageLabel.textColor = JLChatAppearence.outGoingTextColor
    }
    
    open override func configAsIncomingMessage(){
        if JLChatAppearence.showIncomingSenderImage{
            
            self.senderImageView.backgroundColor = JLChatAppearence.senderImageBackgroundColor
            
            self.senderImageView.image = JLChatAppearence.senderImageDefaultImage
            
            self.senderImageHeight.constant = JLChatAppearence.senderImageSize.height
            
            self.senderImageWidth.constant = JLChatAppearence.senderImageSize.width
            
            self.senderImageView.layer.cornerRadius = JLChatAppearence.senderImageCornerRadius
            
            //config the changes only if needs to show the sender image

            senderImageBottomToBubbleBottom.constant = JLChatAppearence.vertivalDistBetweenImgBottom_And_BubbleBottom
            senderImageToBubble.constant = JLChatAppearence.horizontalDistBetweenImg_And_Bubble

        }
        else{
            //self.senderImageHeight.constant = 0
            
            //self.senderImageWidth.constant = 0
            senderImageToBubble.constant = 5
            imageDistToSide.constant = -30
        }
        
        
        self.chatMessageLabel.textColor = JLChatAppearence.incomingTextColor

    }
       
    
}
