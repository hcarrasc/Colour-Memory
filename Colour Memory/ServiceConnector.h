//
//  ServiceConnector.h
//  modulo-movil3
//
//  Created by Hector Carrasco on 24-10-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceConnectorDelegate <NSObject>

-(void)requestReturnedData:(NSData*)data;

@end

@interface ServiceConnector:NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ServiceConnectorDelegate> delegate;

- (void) sendScoreToServer:(NSString*)player withScore:(NSString*)score;
- (void) getScores;

@end
