

import Foundation
import UIKit
import GrowingTextView


class Utilities {
    
    static func styleView(_ viewfield: UIView){
        
        
        viewfield.layer.borderWidth = 0.2
        viewfield.layer.masksToBounds = false
        viewfield.layer.shadowColor = UIColor.gray.cgColor
        viewfield.layer.shadowOpacity = 1.5
        viewfield.layer.shadowOffset = .zero
    }
    
    static func StyleButton(_ button: UIButton){
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0.2
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        
    }
    
    static func buttonstyleView(_ button: UIView){
        
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.opacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
         button.layer.cornerRadius = 10
        
    }
    static func deleteStyleButton(_ button: UIButton){
       // button.layer.cornerRadius = 30
        button.layer.borderWidth = 0.2
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        
    }
    
    
    
    
    static func imageStyle(_ image: UIImageView){
        
        image.layer.cornerRadius = 60
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
        static func titltextview(_ textView: GrowingTextView){
            let textView = GrowingTextView()
            textView.placeholder = "New task"
            textView.placeholderColor = UIColor.lightGray // optional
            textView.maxLength = 140
            textView.trimWhiteSpaceWhenEndEditing = false
            textView.minHeight = 25.0
            textView.maxHeight = 70.0
            textView.backgroundColor = UIColor.white
            
            
    
        }
        static func detailtextview(_ textView: UITextView){
            let textView = GrowingTextView()
        
            
            textView.maxLength = 140
            textView.trimWhiteSpaceWhenEndEditing = false
            textView.placeholder = "Add details"
            textView.placeholderColor = UIColor.lightGray
            textView.minHeight = 25.0
            textView.maxHeight = 70.0
            textView.backgroundColor = UIColor.white
          
        

    }
    
    
    
    
}

extension NSNotification.Name {
    public static let createNewList = NSNotification.Name.init("createNewList")
}
