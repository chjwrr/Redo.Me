//
//  DeviceUUID.m
//  MyCar
//
//  Created by chj on 15/7/2.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "DeviceUUID.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
//需要导入  Security.framework

@implementation DeviceUUID

+(NSString *) getKeychainIdentifier{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"deviceIdentifier" accessGroup:nil];
    //    NSString *username = [wrapper objectForKey:(id)kSecAttrAccount];
    //    NSString *password = [wrapper objectForKey:(id)kSecValueData];
    NSString *uniqueIdentifier = [wrapper objectForKey:(id)kSecAttrAccount];
    // initially all these are empty
    //    NSLog(@"username - %@", username); // username -
    //    NSLog(@"password - %@", password); // password -
    NSLog(@"device_identifier:%@",uniqueIdentifier);
    if ([uniqueIdentifier isEqualToString:@""]) {
        [wrapper setObject:getuuid() forKey:(id)kSecAttrAccount];
        NSLog(@"set uniqueIdentifier.");
    }
    
    uniqueIdentifier = [wrapper objectForKey:(id)kSecAttrAccount];
    NSLog(@"uniqueIdentifier:%@", uniqueIdentifier);
    [wrapper release];
    return uniqueIdentifier;
    
    //if empty set your credentials
    //    if ( [username isEqualToString:@""] ) {
    //        [wrapper setObject:getuuid() forKey:(id)kSecAttrAccount];
    //    }
    //    if ( [password isEqualToString:@""] ) {
    //        [wrapper setObject:getuuid() forKey:(id)kSecValueData];
    //    }
    
    //get the latest credentials - now you have the set values
    //    username = [wrapper objectForKey:(id)kSecAttrAccount];
    //    password = [wrapper objectForKey:(id)kSecValueData];
    
    //    NSLog(@"username - %@", username); // username - your username here
    //    NSLog(@"password - %@", password); // password - your password here
    
    // reset your keychain items - if  needed
    //[wrapper resetKeychainItem];
    
    
} //getDeviceIdentifier


//get uuid c style function
NSString * getuuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}
@end
