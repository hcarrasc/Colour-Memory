#import "ServiceConnector.h"
#import "JSONDictionaryExtensions.h"

@implementation ServiceConnector{
    NSMutableData *receivedData;
}

- (void) getScores{
    NSMutableString* url = [[NSMutableString alloc]init];
    
    [url appendString:@"http://hcarrasco.cl/ScoreServer/getScore.php"];
    NSLog(@"Conectandose a... %@",url);
    
    //build up the request that is to be sent to the server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"getValues" forHTTPHeaderField:@"METHOD"];
    
    //selects what task the server will perform
    receivedData = [[NSMutableData alloc] init];
    
    //initialize an NSURLConnection  with the request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
}

- (void) sendScoreToServer:(NSString*)player withScore:(NSString*)score {
    
    NSURL* url = [NSURL URLWithString:@"http://hcarrasco.cl/ScoreServer/PostScore.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",url);
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:player forKey:@"player_name"];
    [dictionary setValue:score forKey:@"player_score"];
    
    NSLog(@"dic: %@", dictionary);
    
    //serialize the dictionary data as json
    NSData *data = [[dictionary copy] JSONValue];
    
    [request setHTTPBody:data]; //set the data as the post body
    [request addValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    
    receivedData = [[NSMutableData alloc] init];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed POST");
    }
}


#pragma mark - Data connection delegate -

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed with error: %@",error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{ }

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"Request Complete,recieved %lu bytes of data",(unsigned long)receivedData.length);
    [self.delegate requestReturnedData:receivedData];
}

@end
