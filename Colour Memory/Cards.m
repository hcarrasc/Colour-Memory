//
//  Cards.m
//  Colour Memory
//
//  Created by Hector Carrasco on 16-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import "Cards.h"

@implementation Cards
@synthesize color;
@synthesize buttonNumber;
@synthesize ImageColor;


- (void) setColorCard: (NSString*) _color{
    color = _color;
}
- (NSString*) getColorCard{
    return color;
}

- (void) setButtonNumber:(int)_buttonNumber{
    buttonNumber = _buttonNumber;
}
- (int) getButtonNumber{
    return buttonNumber;
}

- (void) setImageColor:(UIImage *) _ImageColor{
    ImageColor = _ImageColor;
}
- (UIImage*) getImageColor{
    return ImageColor;
}

@end
