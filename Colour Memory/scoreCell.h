//
//  scoreCell.h
//  Colour Memory
//
//  Created by Hector Carrasco on 17-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scoreCell : UITableViewCell{
    
}

@property (weak, nonatomic) IBOutlet UILabel *labelPosition;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelScore;

@end
