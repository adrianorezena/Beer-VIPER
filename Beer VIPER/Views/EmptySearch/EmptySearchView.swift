//
//  EmptySearchView.swift
//  Beer VIPER
//
//  Created by Adriano on 15/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit

class EmptySearchView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "EmptySearchView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
