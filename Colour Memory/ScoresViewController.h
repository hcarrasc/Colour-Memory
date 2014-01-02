//
//  ScoresViewController.h
//  Colour Memory
//
//  Created by Hector Carrasco on 16-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnector.h"
#import "JSONDictionaryExtensions.h"
#import "scoreCell.h"

@interface ScoresViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ServiceConnectorDelegate>{}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end
