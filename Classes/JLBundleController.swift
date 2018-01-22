//
//  JLBundleController.swift
//  Pods
//
//  Created by José Lucas Souza das Chagas on 10/12/15.
//
//

import UIKit

/**
 * This class helps you to get this framework bundle, an instance of JLChat.storyboard and an instance of JLChatViewController.
*/
open class JLBundleController {
    
    /**
     * The storyboard file that contains the JLChatViewController
     * The value of it is set by the method loadJLChatStoryboard()
    */
    private(set) public static var jLChatSb:UIStoryboard? = nil

    /**
     * Use it when you have to load something from this framework bundle.
     */
    public class func getBundle()->Bundle?{
        let podBundle = Bundle(for: JLChatViewController.classForCoder())
        
        if let bundleURL = podBundle.url(forResource: "JLChatViewController", withExtension: "bundle") {
            if let assetsBundle = Bundle(url: bundleURL) {
                return assetsBundle
            }
            return nil
        }
        return nil
    }
    
    /**
     * Load the JLChat.storyboard from the bundle of this framework and save its instance on jLChatSb
     */
    public class func loadJLChatStoryboard(){
        let podBundle = Bundle(for: JLChatViewController.classForCoder())
        
        if let bundleURL = podBundle.url(forResource: "JLChatViewController", withExtension: "bundle") {
            
            if let assetsBundle = Bundle(url: bundleURL) {
                
                let storyboard = UIStoryboard(name: "JLChat", bundle: assetsBundle)
                
                self.jLChatSb = storyboard
            }
            
        }
        
    }
    
    /**
    Instantiate the initialViewController of JLChat.storyboard and return it.
    The initialViewController is the JLChatViewController
    */
    public class func instantiateJLChatVC()->UIViewController?{
        
        if let jLChatStoryboard = jLChatSb{
            
            let jLChatFirstVC = jLChatStoryboard.instantiateInitialViewController()
            
            return jLChatFirstVC
        }
        return nil
    }


}
