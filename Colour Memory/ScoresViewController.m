//
//  ScoresViewController.m
//  Colour Memory
//
//  Created by Hector Carrasco on 16-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import "ScoresViewController.h"

@interface ScoresViewController ()

@end

@implementation ScoresViewController

NSMutableArray *arrayName;
NSMutableArray *arrayScore;
NSMutableArray *arrayPosition;
UIActivityIndicatorView *activityIndicator;
int total = 0;
int positions[50];

@synthesize mainView;
@synthesize myTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	ServiceConnector *serviceConnector = [[ServiceConnector alloc] init];
    serviceConnector.delegate = self;
    [serviceConnector getScores];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(160, 240);
    activityIndicator.hidesWhenStopped = NO;
    [mainView addSubview:activityIndicator];
    [activityIndicator startAnimating];

    
    arrayName = [[NSMutableArray alloc] initWithCapacity:50];
    arrayScore = [[NSMutableArray alloc] initWithCapacity:50];
    arrayPosition = [[NSMutableArray alloc] initWithCapacity:50];
}

-(void)requestReturnedData:(NSData *)data{

    /* Este metodo se ejecuta cuando terminan de descargarse toda la tabla de High scores desde el servidor */
    
    int i = 0;
    @try {
        NSError *myError = nil;
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
        NSLog(@"JSON: %@", res);

    
        if(res == NULL){
            
            UIAlertView *message = [[UIAlertView alloc]
                                    initWithTitle:@"Error inesperado"
                                    message:@"Porfavor, intentelo nuevamente"
                                    delegate:nil
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:nil];
            [message show];
        }
        else{
            total = [[res objectForKey:@"total"] intValue];
            NSArray *results = [res objectForKey:@"data"];
            
            for (NSDictionary *result in results) {
                [arrayName addObject:[result objectForKey:@"player_name"]];
                [arrayScore addObject:[result objectForKey:@"player_score"]];
                [arrayPosition addObject:[result objectForKey:@"player_score"]];
                i++;
                positions[i] = i;
            }
            
        }
    
    /* Si ya se ha descargado todos los datos, se carga el contenido en el UITableView */
        
    if(i==total){
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        [[self myTableView] setDataSource:self];
        [[self myTableView] setDelegate:self];
        [myTableView reloadData];
    }
    }
    @catch (NSException *exception) {}
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /* Este metodo crea celda por celda que seran visibles en la UITableView */
    
    static NSString *cellIdentifier = @"Cell";
    NSMutableString *currentScore = [[NSMutableString alloc] init];
    [currentScore setString:@""];
    [currentScore appendFormat:@"%d", positions[indexPath.item]];

    scoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [[cell labelName] setText: [arrayName objectAtIndex:indexPath.item]];
    [[cell labelScore] setText:[arrayScore objectAtIndex:indexPath.item]];
    [[cell labelPosition] setText: currentScore];
    return cell;
    
}

@end
