//
//  ShuntingYardAlgorithm.h
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
#import "PriorityCheck.h"

@interface ShuntingYardAlgorithm : NSObject

@property NSMutableArray *operands;

@property NSMutableArray *operators;

@property NSMutableArray *postfixNotaion;

-(NSMutableArray*)convertToPostfix:(NSMutableArray*)infix;

-(Fraction*)calculateAnswer;


@end
