//
//  EmptySearchView.swift
//  Beer VIPER
//
//  Created by Adriano on 15/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit

class EmptySearchView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet var contentView: UIView!
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        //commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("EmptySearchView", owner: self, options: nil)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(contentView)
        
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "EmptySearchView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    
}
