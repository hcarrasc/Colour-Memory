//
//  BoardViewController.m
//  Colour Memory
//
//  Created by Hector Carrasco on 16-12-13.
//  Copyright (c) 2013 Hector Carrasco. All rights reserved.
//

#import "BoardViewController.h"
#import "ServiceConnector.h"

@interface BoardViewController ()

@end

@implementation BoardViewController
@synthesize button1, button2, button3, button4, button5;
@synthesize button6, button7, button8, button9, button10;
@synthesize button11, button12, button13, button14, button15, button16;
@synthesize scoreLabel;

NSMutableArray *colorCards;
NSMutableArray *repeated;
NSMutableString *currentScore;
NSString *colorIntent1;
NSString *colorIntent2;

int tagButton1 = 0;
int tagButton2 = 0;
int intents = 0;
int totalCards = 16;
int numberCardsControl = 16;
int randd = 0;
int score = 0;

@synthesize nameTextField, messageView, messageLabel;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    /* Inicializacion de variables */
    colorCards = [[NSMutableArray alloc] initWithCapacity:16];
    repeated   = [[NSMutableArray alloc] initWithCapacity:16];
    currentScore = [[NSMutableString alloc] init];
    nameTextField.delegate = self;
    
    /* Creacion de las cartas */
    [self initCards];
    scoreLabel.text = @"Score: 0";
    
    /* Se oculta el panel en el cual se ingresa el nombre del jugador antes de enviar el puntaje al servidor */
    CGFloat x1 = 465;
    CGFloat y1 = 90;
    CGPoint position = CGPointMake(x1, y1);
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        messageView.center = position;
    } completion:^(BOOL finished) { }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectedCard:(id)sender {
    
    intents++;
    
    /* Cuando se realiza la seleción de la primera carta ejecuta este condicional */
    
    if(intents == 1){
        for (int i=0; i<colorCards.count; i++) {
            if([sender tag]==[[colorCards objectAtIndex:i] getButtonNumber]){
                
                colorIntent1 = [[colorCards objectAtIndex:i] getColorCard];
                [sender setImage:[[colorCards objectAtIndex:i] getImageColor] forState:UIControlStateNormal];
            }
        }
        tagButton1 = [sender tag];
    }
    
    /* Si se realiza la seleción de la segunda carta ejecuta este condicional */
    
    if(intents == 2){
        
        for (int i=0; i<colorCards.count; i++) {
            if([sender tag]==[[colorCards objectAtIndex:i] getButtonNumber]){
                [sender setImage:[[colorCards objectAtIndex:i] getImageColor] forState:UIControlStateNormal];
                colorIntent2 = [[colorCards objectAtIndex:i] getColorCard];
            }
        }
        tagButton2 = [sender tag];
        
        intents = 0;
        
        /* Si acierta en la seleccion de ambas cartas se suman 2 puntos en el score */
        
        if([colorIntent1 isEqualToString:colorIntent2]){
            score = score + 2;
            [currentScore setString:@""];
            [currentScore appendString:@"score: "];
            [currentScore appendFormat:@"%d", score];
            scoreLabel.text = currentScore;
            
            [self removeButton1];
            [self removeButton2];
            
            numberCardsControl = numberCardsControl - 2;
            
            /* Si se han acabado las cartas sobre el tablero, el juego termina y se visualiza el panel para ingresar el nombre del jugador */
            
            if(numberCardsControl<=0){
                
                CGFloat x1 = 160;
                CGFloat y1 = 90;
                CGPoint posicion = CGPointMake(x1, y1);

                [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
                    messageView.center = posicion;
                } completion:^(BOOL finished) { }];
                numberCardsControl = 16;
            }
        }
        
        /* Si falla en la seleción de las cartas se resta 1 punto en el score */
        
        else{
            score = score - 1;
            [currentScore setString:@""];
            [currentScore appendString:@"score: "];
            [currentScore appendFormat:@"%d", score];
            scoreLabel.text = currentScore;
            
            /* Como ha fallado, se procede a voltear las cartas nuevamente */
            
            [self performSelector:@selector(resetButtons2) withObject:@"" afterDelay:0.8f];
            [self performSelector:@selector(resetButtons1) withObject:@"" afterDelay:0.8f];
        }
        
    }
}

- (IBAction)sendData:(id)sender {
    
    /* Este metodo envia los datos al servidor estableciendo una conexion HTTP por metodo post*/
    
    if(![nameTextField.text  isEqualToString: @""]){
        
        messageLabel.text = @"Sended data to server!";
        ServiceConnector *serviceConnector = [[ServiceConnector alloc] init];
        
        NSMutableString *aux = [[NSMutableString alloc] init];
        [aux appendFormat:@"%d", score];
        NSLog(@"socre: %@",aux);
        [serviceConnector sendScoreToServer:nameTextField.text withScore: aux];
        
        [self.nameTextField resignFirstResponder];
        
        CGFloat x1 = 465;
        CGFloat y1 = 90;
        CGPoint position = CGPointMake(x1, y1);
        
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            messageView.center = position;
        } completion:^(BOOL finished) { }];
    }
}

/* Al crear las cartas este metodo comprueba que a una carta no se le asigne un boton ya repetido  */

- (bool) isRepeated: (int) randd{
    
    for(int i=0; i<[repeated count];i++){
        if(randd == [[repeated objectAtIndex:i] integerValue]){
            return true;
        }
    }
    [repeated addObject:[NSNumber numberWithInt:randd]];
    return false;
}


/* Obtiene un numero aleatorio */
- (int) getRandNumber{
    int randd = 0;
    do {
        randd = arc4random() % totalCards;
    }while ([self isRepeated:randd]);
    if(randd == 0){
        randd = 16;
    }
    
    return randd;
}

- (void) resetButtons1 {
    switch (tagButton1) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button1 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button2 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 3:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button3 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 4:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button4 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 5:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button5 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        
        case 6:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button6 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 7:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button7 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 8:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button8 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 9:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button9 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 10:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button10 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 11:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button11 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 12:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button12 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 13:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button13 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 14:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button14 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 15:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button15 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 16:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button16 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        default:
            break;
    }
}

- (void) resetButtons2 {
    switch (tagButton2) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button1 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button2 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 3:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button3 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 4:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button4 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 5:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button5 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 6:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button6 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 7:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button7 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 8:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button8 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 9:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button9 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 10:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button10 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 11:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button11 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 12:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button12 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 13:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button13 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 14:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button14 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 15:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button15 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 16:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button16 setImage:[UIImage imageNamed:@"interrogation.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        default:
            break;
    }
}

- (void) removeButton1{
    switch (tagButton1) {
        case 1:
            button1.alpha = 0;
            break;
        case 2:
            button2.alpha = 0;
            break;
        case 3:
            button3.alpha = 0;
            break;
        case 4:
            button4.alpha = 0;
            break;
        case 5:
            button5.alpha = 0;
            break;
        case 6:
            button6.alpha = 0;
            break;
        case 7:
            button7.alpha = 0;
            break;
        case 8:
            button8.alpha = 0;
            break;
        case 9:
            button9.alpha = 0;
            break;
        case 10:
            button10.alpha = 0;
            break;
        case 11:
            button11.alpha = 0;
            break;
        case 12:
            button12.alpha = 0;
            break;
        case 13:
            button13.alpha = 0;
            break;
        case 14:
            button14.alpha = 0;
            break;
        case 15:
            button15.alpha = 0;
            break;
        case 16:
            button16.alpha = 0;
            break;
            
        default:
            break;
    }

}

- (void) removeButton2{
    switch (tagButton2) {
        case 1:
            button1.alpha = 0;
            break;
        case 2:
            button2.alpha = 0;
            break;
        case 3:
            button3.alpha = 0;
            break;
        case 4:
            button4.alpha = 0;
            break;
        case 5:
            button5.alpha = 0;
            break;
        case 6:
            button6.alpha = 0;
            break;
        case 7:
            button7.alpha = 0;
            break;
        case 8:
            button8.alpha = 0;
            break;
        case 9:
            button9.alpha = 0;
            break;
        case 10:
            button10.alpha = 0;
            break;
        case 11:
            button11.alpha = 0;
            break;
        case 12:
            button12.alpha = 0;
            break;
        case 13:
            button13.alpha = 0;
            break;
        case 14:
            button14.alpha = 0;
            break;
        case 15:
            button15.alpha = 0;
            break;
        case 16:
            button16.alpha = 0;
            break;
            
        default:
            break;
    }
    
}

- (void) initCards{
    
    /* Este metodo iniciliza los objetos cards, estableciendo la imagen del color que va a contener y el uiboton al cual sera asignada */
    
    Cards *card1 = [[Cards alloc] init];
    Cards *card2 = [[Cards alloc] init];
    [card1 setImageColor: [UIImage imageNamed:@"black.png"]];
    [card1 setColor:@"black"];
    [card2 setImageColor: [UIImage imageNamed:@"black.png"]];
    [card2 setColor:@"black"];
    [card1 setButtonNumber: [self getRandNumber]];
    [card2 setButtonNumber: [self getRandNumber]];
    [colorCards addObject:card1];
    [colorCards addObject:card2];
    
    Cards *card3 = [[Cards alloc] init];
    Cards *card4 = [[Cards alloc] init];
    [card3 setImageColor: [UIImage imageNamed:@"white.png"]];
    [card3 setColor:@"white"];
    [card4 setImageColor: [UIImage imageNamed:@"white.png"]];
    [card4 setColor:@"white"];
    [card3 setButtonNumber:[self getRandNumber]];
    [card4 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card3];
    [colorCards addObject:card4];
    
    Cards *card5 = [[Cards alloc] init];
    Cards *card6 = [[Cards alloc] init];
    [card5 setImageColor: [UIImage imageNamed:@"blue.png"]];
    [card5 setColor:@"blue"];
    [card6 setImageColor: [UIImage imageNamed:@"blue.png"]];
    [card6 setColor:@"blue"];
    [card5 setButtonNumber:[self getRandNumber]];
    [card6 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card5];
    [colorCards addObject:card6];
    
    Cards *card7 = [[Cards alloc] init];
    Cards *card8 = [[Cards alloc] init];
    [card7 setImageColor: [UIImage imageNamed:@"brown.png"]];
    [card7 setColor:@"brown"];
    [card8 setImageColor: [UIImage imageNamed:@"brown.png"]];
    [card8 setColor:@"brown"];
    [card7 setButtonNumber:[self getRandNumber]];
    [card8 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card7];
    [colorCards addObject:card8];
    
    Cards *card9 = [[Cards alloc] init];
    Cards *card10 = [[Cards alloc] init];
    [card9 setImageColor: [UIImage imageNamed:@"green.png"]];
    [card9 setColor:@"green"];
    [card10 setImageColor: [UIImage imageNamed:@"green.png"]];
    [card10 setColor:@"green"];
    [card9 setButtonNumber:[self getRandNumber]];
    [card10 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card9];
    [colorCards addObject:card10];
    
    Cards *card11 = [[Cards alloc] init];
    Cards *card12 = [[Cards alloc] init];
    [card11 setImageColor: [UIImage imageNamed:@"purple.png"]];
    [card11 setColor:@"purple"];
    [card12 setImageColor: [UIImage imageNamed:@"purple.png"]];
    [card12 setColor:@"purple"];
    [card11 setButtonNumber:[self getRandNumber]];
    [card12 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card11];
    [colorCards addObject:card12];
    
    Cards *card13 = [[Cards alloc] init];
    Cards *card14 = [[Cards alloc] init];
    [card13 setImageColor: [UIImage imageNamed:@"red.png"]];
    [card13 setColor:@"red"];
    [card14 setImageColor: [UIImage imageNamed:@"red.png"]];
    [card14 setColor:@"red"];
    [card13 setButtonNumber:[self getRandNumber]];
    [card14 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card13];
    [colorCards addObject:card14];
    
    Cards *card15 = [[Cards alloc] init];
    Cards *card16 = [[Cards alloc] init];
    [card15 setImageColor: [UIImage imageNamed:@"yellow.png"]];
    [card15 setColor:@"yellow"];
    [card16 setImageColor: [UIImage imageNamed:@"yellow.png"]];
    [card16 setColor:@"yellow"];
    [card15 setButtonNumber:[self getRandNumber]];
    [card16 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card15];
    [colorCards addObject:card16];
}

@end
