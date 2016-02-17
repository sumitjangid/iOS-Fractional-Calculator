//
//  PriorityCheck.h
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriorityCheck : NSObject

-(BOOL)checkPriority:(NSString*)op1 secondOp:(NSString*)op2;

-(int)getPriority:(NSString*)operator;

@end
