
#import <Foundation/Foundation.h>

@interface NSDictionary (JSONExtensions)

+(NSDictionary*)dictionaryWithJSONData:(NSData*)data;
-(NSData*)JSONValue;
-(NSString*)JSONString;

@end

@implementation NSDictionary(JSONExtensions)

+(NSDictionary*)dictionaryWithJSONData:(NSData*)data{
    NSError *error = nil;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error){
        NSLog(@"%@",error);
        return nil;
    };
    return result;
}

-(NSData*)JSONValue{
    NSError *error = nil;
    
    NSData *result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if(error){
        NSLog(@"%@",error);
        return nil;
    };
    
    return result;
}

-(NSString*)JSONString{
    return [[NSString alloc] initWithData:self.JSONValue encoding:NSUTF8StringEncoding];
}

@end
