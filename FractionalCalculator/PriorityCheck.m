//
//  PriorityCheck.m
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import "PriorityCheck.h"

@implementation PriorityCheck

// check the priority of the operators according to the PEMDAS
-(BOOL)checkPriority:(NSString*)op1 secondOp:(NSString*)op2
{
    
    if([self getPriority:op1]<[self getPriority:op2])
    {
        return YES;
        
    }
    else
    {
        return NO;
    }
}

-(int)getPriority:(NSString*)operator
{
    // define the rules for priority
    if([operator isEqualToString:@"*"] || [operator isEqualToString:@"/"])
    {
        // * and / has higher priority
        return 2;
    }
    if([operator isEqualToString:@"+"] || [operator isEqualToString:@"-"])
    {
        // + and - has lower priority
        return 1;
    }
    return 0;
}

@end
