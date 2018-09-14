//
//  XYUserJudgeView.swift
//  XiongDaJinFu
//
//  Created by 威威孙 on 2017/5/22.
//  Copyright © 2017年 digirun. All rights reserved.
//

import UIKit

class XYUserJudgeView: UIView {

    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var nextTimeBtn: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var judgeBtn: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //按钮点击block
    var btnClickBlock:((Int)->())?;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgImageView.isUserInteractionEnabled = true
        self.nextTimeBtn.layer.borderColor = UIColor.init(red: 37/255, green: 149/255, blue: 217/255, alpha: 1).cgColor
        self.nextTimeBtn.layer.borderWidth = 1
        
//        UserDefaults.standard.set(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
    }
    
    
    
    @IBAction func exitBtnClick(_ sender: UIButton) {
        if btnClickBlock != nil {
            //注意：属性btnClickBlock是可选类型，需要先解包
            self.btnClickBlock!(1);
        }
        print("退出")
    }
    
    
    @IBAction func judgeBtnCLick(_ sender: UIButton) {
        if btnClickBlock != nil {
            //注意：属性btnClickBlock是可选类型，需要先解包
            self.btnClickBlock!(2);
        }
        print("去评价")
    }

}
