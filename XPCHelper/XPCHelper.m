//
//  XPCHelper.m
//  XPCHelper
//
//  Created by petera on 2/6/23.
//

#import "XPCHelper.h"

@implementation XPCHelper

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

@end
