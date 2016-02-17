//
//  Fraction.h
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject<NSCopying>

@property int numerator;
@property int denominator;
@property int minusFlag;

-(Fraction*)add:(Fraction*)op2;
-(Fraction*)subtract:(Fraction*)op2;
-(Fraction*)divide:(Fraction*)op2;
-(Fraction*)multiply:(Fraction*)op2;
-(Fraction*)squareRoot:(Fraction*)op2;
-(NSMutableArray*)findRoot:(int)num;


@end
