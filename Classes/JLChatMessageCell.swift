//
//  JLChatMessageCell.swift
//  Pods
//
//  Created by José Lucas Souza das Chagas on 10/12/15.
//
//

import UIKit

open class JLChatMessageCell: UITableViewCell {
    
    /**
     This variable indicates if this cell is being reused.
     
     
     If value is true so you don't have to configure it again as outgoing or incoming message.
     
     If value is false so you have to configure it again as outgoing or incoming message.

    */
    public var cellAlreadyUsed:Bool = false


    public private(set) var isMenuConfigured:Bool = false
    
    internal var isOutgoingMessage:Bool = false
    
    private var sendBlock:(()->())!
    private var deleteBlock:(()->())!
    
    internal var sendMenuEnabled:()->Bool = { () -> Bool in
        
        return true
    }

    
    internal var deleteMenuEnabled:()->Bool = { () -> Bool in
        
        return true
    }

  
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.alpha = 1
    }
    

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override open var canBecomeFirstResponder: Bool {
        return true
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if (action == #selector(JLChatMessageCell.deleteAction(_:)) && deleteMenuEnabled()) || (action == #selector(JLChatMessageCell.sendAction(_:)) && sendMenuEnabled()){
            return true
        }
        
        return false
    }

    
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        
        NotificationCenter.default.addObserver(self, selector:#selector(JLChatMessageCell.menuDismissed(_:)), name: NSNotification.Name.UIMenuControllerDidHideMenu, object: nil)
        
        return super.becomeFirstResponder()
        
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        
        //NSNotificationCenter.default().removeObserver(self, name: UIMenuControllerDidHideMenuNotification, object: nil)
        
        return super.resignFirstResponder()
    }
    
    
    
    /**
     The implementation of this method have to contain every code that is necessary to initialize the message cell.
     
        DEPRECATED
    */

    @available(*,deprecated,renamed: "initCell(message:thisIsNewMessage:isOutgoingMessage:)",message: "This method is deprecated use initCell(message:thisIsNewMessage:isOutgoingMessage:)")
    open func initCell(message:JLMessage,thisIsNewMessage:Bool,showDate:Bool,isOutgoingMessage:Bool){
       
        self.isOutgoingMessage = isOutgoingMessage
        
    }
    
    /**
     The implementation of this method have to contain every code that is necessary to initialize the message cell.
     
     You must override this method.
     
     */
    open func initCell(message:JLMessage,thisIsNewMessage:Bool,isOutgoingMessage:Bool){
        
        self.isOutgoingMessage = isOutgoingMessage
        
    }
    
    
    //MARK: Status methods
    /**
    The implementation of this method have to contain every code that is necessary to update the message cell status accordingly to the message related to this cell.
    
    
    You must override this method.

    
    - parameter message: The 'JLMessage' instance related to its cell with its 'messageStatus' updated.
    */
    open func updateMessageStatus(message:JLMessage){
        
    }
    /**
     
     Present the 'errorButton'.
     
     You must override this method.
     */
    open func showErrorButton(animated:Bool){
        
    }
    /**
     Hide the 'errorButton'.
     
     You must override this method.
     */
    open func hideErrorButton(animated:Bool){
       
    }
    
    //MARK: MenuController methods
    
    @objc open func menuDismissed(_ notification:NSNotification){
        
        self.resignFirstResponder()
        
    }
    
    /**
     Use this method to configure the menu items of this cell 'UIMenuController'
     - parameter deleteTitle: the title of the menu item that indicates the delete action.
     - parameter senTitle: the title of menu item that indicates the try to send again action.
     - parameter deleteBlock: action that is executed when delete menu item is clicked.
     - parameter sendBlock: action that is executed when send menu item is clicked.

     */
    open func configMenu(deleteTitle:String?,sendTitle:String?,deleteBlock:@escaping ()->(),sendBlock:@escaping ()->()){
        
        var menus:[UIMenuItem] = [UIMenuItem]()
        
        isMenuConfigured = true
        
        if let deleteTitle = deleteTitle{
            menus.append(UIMenuItem(title: deleteTitle, action: #selector(JLChatMessageCell.deleteAction(_:))))
        }
        else{
            menus.append(UIMenuItem(title: "Delete", action:#selector(JLChatMessageCell.deleteAction(_:))))
        }
        
        if let sendTitle = sendTitle{
            menus.append(UIMenuItem(title: sendTitle, action: #selector(JLChatMessageCell.sendAction(_:))))
        }
        else{
            menus.append(UIMenuItem(title: "Try Again", action: #selector(JLChatMessageCell.sendAction(_:))))
        }
        
        UIMenuController.shared.menuItems = menus
        
        UIMenuController.shared.update()
        
        self.deleteBlock = deleteBlock
        self.sendBlock = sendBlock

    }
    
    @objc open func deleteAction(_ sender:AnyObject){
        
        print("delete")
        deleteBlock()
        
    }
    
    @objc open func sendAction(_ sender:AnyObject){
        
        print("send")
        sendBlock()
        
    }
    
    
    //MARK: Config methods
    /**
    The implementation of this method have to contain every code that is necessary to configure the message cell as a outgoing message.
    
    You must override this method.
    */
    open func configAsOutgoingMessage(){
        
        
        
    }
    /**
     The implementation of this method have to contain every code that is necessary to configure the message cell as a incoming message.
     
     You must override this method.

     */
    open func configAsIncomingMessage(){
        
    }
    
}
