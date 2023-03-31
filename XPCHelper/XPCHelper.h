//
//  XPCHelper.h
//  XPCHelper
//
//  Created by petera on 2/6/23.
//

#import <Foundation/Foundation.h>
#import "XPCHelperProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XPCHelper : NSObject <XPCHelperProtocol>
@end
