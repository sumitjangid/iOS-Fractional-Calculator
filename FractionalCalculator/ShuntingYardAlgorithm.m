//
//  ShuntingYardAlgorithm.m
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import "ShuntingYardAlgorithm.h"

@implementation ShuntingYardAlgorithm

-(id)init
{
    self=[super init];
    if(self)
    {
        self.operators=[[NSMutableArray alloc]init];
        self.operands=[[NSMutableArray alloc]init];
    }
    return self;
}

//convert infix equation to postfix using shunting Algorithm
-(NSMutableArray*)convertToPostfix:(NSMutableArray*)infix
{
    NSMutableArray *postfix = [[NSMutableArray alloc]init];
    NSString* temp2 ;
    for(id i in infix)
    {
        if([i isKindOfClass:[Fraction class]])
        {
            [postfix addObject:i];
        }
        
        else{
            temp2 = (NSString*)i;
            NSLog(@"Operator is %@ ",temp2);
            
            if([self.operators count]!=0)
            {
                while(YES)
                    
                {
                    if([self.operators count]==0)
                    {
                        break;
                    }
                    
                    PriorityCheck* P= [[PriorityCheck alloc]init];
                    
                    NSString* temp1 = [self.operators objectAtIndex:([self.operators count]-1)];
                    
                    if([P checkPriority:temp2 secondOp:temp1])
                    {
                        [postfix addObject:temp1];
                        [self.operators removeLastObject];
                        
                    }
                    else
                    {
                        break;
                    }
                }
            }
            
            [self.operators addObject:i];
            NSLog(@"stack operator %lu",(unsigned long)[self.operators count] );
        }
    }
    for(unsigned long i=[self.operators count];i>0;i--)
    {
        NSLog(@"stack status");
        
        [postfix addObject:[self.operators objectAtIndex:i-1]];
    }
    self.postfixNotaion = postfix;
    
    return postfix;
}

//Calculate the postfix equation using the stacks
-(Fraction*)calculateAnswer
{
    Fraction *answer;
    NSMutableArray *process=[[NSMutableArray alloc]init];
    for (id i in self.postfixNotaion)
    {
        if([i isKindOfClass:[Fraction class]])
        {
            [process addObject:i];
        }
        else
        {
            Fraction *f1 = [process objectAtIndex:[process count]-1];
            Fraction *f2 = [process objectAtIndex:[process count]-2];
            [process removeLastObject];
            [process removeLastObject];
            // do some calculations
            
            if([(NSString*)i isEqualToString:@"+"])
                answer = [f1 add:f2];
            else if ([(NSString*)i isEqualToString:@"-"])
                answer = [f2 subtract:f1];
            else if ([(NSString*)i isEqualToString:@"/"])
                answer = [f2 divide:f1];
            else
                answer = [f1 multiply:f2];
            
            [process addObject:answer];
        }
    }
    return answer;
}

@end
