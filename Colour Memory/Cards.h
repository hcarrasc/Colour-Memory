//
//  Cards.h
//  Colour Memory
//
//  Created by Hector Carrasco on 16-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cards : NSObject{
    
}

@property (nonatomic) NSString *color;
@property (nonatomic) int buttonNumber;
@property (nonatomic) UIImage  *ImageColor;

- (void) setColorCard: (NSString*) _color;
- (NSString*) getColorCard;

- (void) setButtonNumber:(int)_buttonNumber;
- (int) getButtonNumber;

- (void) setImageColor:(UIImage *)_ImageColor;
- (UIImage*) getImageColor;

@end