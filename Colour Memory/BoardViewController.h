//
//  BoardViewController.h
//  Colour Memory
//
//  Created by Hector Carrasco on 16-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cards.h"

@interface BoardViewController : UIViewController <UITextFieldDelegate>{
    
}

/* Declaración de IBOutlets */
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button16;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *boardView;

- (void) initCards;
- (IBAction)selectedCard:(id)sender;
- (IBAction)sendData:(id)sender;
- (bool) isRepeated: (int) randd;
- (int) getRandNumber;
- (void) resetButtons1;
- (void) resetButtons2;
- (void) removeButton1;
- (void) removeButton2;

@end
