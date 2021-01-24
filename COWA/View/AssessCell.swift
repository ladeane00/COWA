//
//  AssessCell.swift
//  COWA
//
//  Created by Lucas Deane on 11/2/20.
//

import UIKit

class AssessCell: UITableViewCell {
    
    @IBOutlet weak var AIDLabel: UILabel!
    @IBOutlet weak var SIDLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var VisitNumLabel: UILabel!
    @IBOutlet weak var ExportedLabel: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        @IBInspectable var borderColor: UIColor? {
            didSet {
                layer.borderColor = borderColor?.cgColor
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

