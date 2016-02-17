//
//  Fraction.m
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

-(Fraction*)add:(Fraction*)op2
{
    Fraction *answer = [[Fraction alloc]init];
    
    // Case 1: if denominators are same we simply add the numerators of two fractions
    if(self.denominator==op2.denominator)
    {
        answer.denominator = self.denominator;
        answer.numerator = self.numerator + op2.numerator;
        if( answer.numerator!=0 && answer.denominator!=0)
        {
            if(answer.numerator%answer.denominator==0)
            {
                answer.numerator = answer.numerator/answer.denominator;
                answer.denominator=1;
            }
            if(answer.denominator%answer.numerator==0)
            {
                answer.denominator= answer.denominator/answer.numerator;
                answer.numerator=1;
            }
        }
        return answer;
    }
    
    // if the denominators are not same we calculate the GCD and LCM
    else
    {
        int a, b, x, y, t, gcd, lcm;
        
        x= self.denominator;
        y= op2.denominator;
        a = x;
        b = y;
        
        //t is a temp variable
        while (b != 0) {
            t = b;
            b = a % b;
            a = t;
        }
    
        gcd = a;
        lcm = (x*y)/gcd;
        
        printf("Greatest common divisor of %d and %d = %d\n", x, y, gcd);
        printf("Least common multiple of %d and %d = %d\n", x, y, lcm);
        
        answer.numerator = (self.numerator*(lcm/self.denominator)) + (op2.numerator*(lcm/op2.denominator));
        
        answer.denominator = lcm;
        if(answer.numerator%answer.denominator==0)
        {
            answer.numerator = answer.numerator/answer.denominator;
            answer.denominator=1;
        }
        if(answer.denominator%answer.numerator==0)
        {
            answer.denominator= answer.denominator/answer.numerator;
            answer.numerator=1;
        }
        return answer;
    }
}
-(Fraction*)subtract:(Fraction*)op2
{
    Fraction *answer = [[Fraction alloc]init];
    
    //Case 1: if denominators are same we simply subtract the numerators of two fractions
    if(self.denominator==op2.denominator)
    {
        answer.denominator = self.denominator;
        answer.numerator = self.numerator - op2.numerator;
        NSLog(@"Numerator is %d Numerator %d", self.numerator ,op2.numerator );
        if( answer.numerator!=0 && answer.denominator!=0)
        {
            if(answer.numerator%answer.denominator==0 && answer.numerator!=0)
            {
                answer.numerator = answer.numerator/answer.denominator;
                answer.denominator=1;
            }
            if(answer.denominator%answer.numerator==0 && answer.numerator!=0)
            {
                answer.denominator= answer.denominator/answer.numerator;
                answer.numerator=1;
            }
        }
        return answer;
    }
    
    // if the denominators are not same we calculate the GCD and LCM
    else
    {
        int a, b, x, y, t, gcd, lcm;
        
        x= self.denominator;
        y= op2.denominator;
        a = x;
        b = y;
        
        while (b != 0) {
            t = b;
            b = a % b;
            a = t;
        }
        
        gcd = a;
        lcm = (x*y)/gcd;
        
        printf("Greatest Common Divisor of %d and %d = %d\n", x, y, gcd);
        printf("Least Common Multiple of %d and %d = %d\n", x, y, lcm);
        
        answer.numerator = (self.numerator*(lcm/self.denominator)) - (op2.numerator*(lcm/op2.denominator));
        answer.denominator = lcm;
        
        if(answer.numerator%answer.denominator==0 && answer.numerator!=0)
        {
            answer.numerator = answer.numerator/answer.denominator;
            answer.denominator=1;
        }
        if(answer.denominator%answer.numerator==0 && answer.numerator!=0)
        {
            answer.denominator= answer.denominator/answer.numerator;
            answer.numerator=1;
        }
        return answer;
    }
}
-(Fraction*)divide:(Fraction*)op2
{
    Fraction *answer = [[Fraction alloc]init];
    answer.numerator = (self.numerator)*(op2.denominator);
    answer.denominator = (self.denominator)*(op2.numerator);
    
    // if the numerator is completely divisible by denominator or visa versa
    if( answer.numerator!=0 && answer.denominator!=0)
    {
        if(answer.numerator%answer.denominator==0)
        {
            answer.numerator = answer.numerator/answer.denominator;
            answer.denominator=1;
        }
        if(answer.denominator%answer.numerator==0)
        {
            answer.denominator= answer.denominator/answer.numerator;
            answer.numerator=1;
        }
    }
    return answer;
}
-(Fraction*)multiply:(Fraction*)op2
{
    Fraction *answer = [[Fraction alloc]init];
    answer.numerator = (self.numerator)*(op2.numerator);
    answer.denominator = (self.denominator)*(op2.denominator);
    
    // if the numerator is completely divisible by denominator or visa versa
    if( answer.numerator!=0 && answer.denominator!=0)
    {
        if(answer.numerator%answer.denominator==0 && answer.numerator!=0)
        {
            answer.numerator = answer.numerator/answer.denominator;
            answer.denominator=1;
        }
        if(answer.denominator%answer.numerator==0 && answer.numerator!=0)
        {
            answer.denominator= answer.denominator/answer.numerator;
            answer.numerator=1;
        }
    }
    return answer;
}

-(NSMutableDictionary*)squareRoot:(Fraction*)op2
{
    NSLog(@"inside square root method %d %d",op2.numerator,op2.denominator );
    NSMutableDictionary *final = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *rootOfNumerator = [self findRoot:op2.numerator];
    
    //PartOne contains the number whose squareroot is a whole number
    
    //PartTwo is the number whose squareroot is not a whole number
    
    int numeratorPartOne=1;
    int numeratorPartTwo =1;
    
    for(id key in rootOfNumerator)
    {
        double answer;
        
        if([[rootOfNumerator objectForKey:key] intValue]%2==0)
        {
            answer = sqrt(pow([key intValue], [[rootOfNumerator objectForKey:key] intValue]));
            numeratorPartOne = numeratorPartOne*answer;
        }
        else
        {
            if(([[rootOfNumerator objectForKey:key] intValue]-1) != 0)
            {
                answer = sqrt(pow([key intValue], ([[rootOfNumerator objectForKey:key] intValue])-1));
                numeratorPartOne = numeratorPartOne*answer;
                numeratorPartTwo = numeratorPartTwo*[key intValue];
            }
            else
            {
                numeratorPartTwo = numeratorPartTwo*[key intValue];
            }
        }
    }
    [final setObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:numeratorPartOne],[NSNumber numberWithInt:numeratorPartTwo], nil] forKey:@"numerator"];
    NSLog(@"NumeratorPartOne is %d and NumeratorPartTwo is %d",numeratorPartOne,numeratorPartTwo);
    NSMutableDictionary *rootOfDenominator = [self findRoot:op2.denominator];
    int denominatorPartOne=1;
    int denominatorPartTwo =1;
    
    for(id key in rootOfDenominator)
    {
        double answer;
        
        if([[rootOfDenominator objectForKey:key] intValue]%2==0)
        {
            answer = sqrt(pow([key intValue], [[rootOfDenominator objectForKey:key] intValue]));
            denominatorPartOne= denominatorPartOne*answer;
        }
        else
        {
            if(([[rootOfDenominator objectForKey:key] intValue]-1) != 0)
            {
                answer = sqrt(pow([key intValue], ([[rootOfDenominator objectForKey:key] intValue])-1));
                denominatorPartOne = denominatorPartOne*answer;
                denominatorPartTwo = denominatorPartTwo*[key intValue];
            }
            else
            {
                denominatorPartTwo = denominatorPartTwo*[key intValue];
            }
        }
    }
    [final setObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:denominatorPartOne],[NSNumber numberWithInt:denominatorPartTwo], nil] forKey:@"denominator"];
    
    return final;
}

-(NSMutableDictionary*)findRoot:(int)num
{
    // find all the prime divisors of the number
    NSMutableArray* allprime = [[NSMutableArray alloc]init];
    for(int i=2;i<=num;i++)
    {
        if((num%i)==0)
        {
            int q = i;
            int count=0;
            for(int j=1;j<=q;j++)
            {
                if(q%j==0)
                    count++;
            }
            if(count==2)
            {
                [allprime addObject:[NSNumber numberWithInt:q]];
            }
        }
    }
    
    //find how many times a prime divisor divides that numnber
    NSMutableDictionary *final = [[NSMutableDictionary alloc]init];
    for(NSNumber *i in allprime)
    {
        int count=0;
        int q=[i intValue];
        int number = num;
        while(YES)
        {
            if(number%q==0)
            {
                count++;
                number = number/q;
            }
            else
            {
                break;
            }
        }
        [final setObject:[NSNumber numberWithInt:count] forKey:[NSNumber numberWithInt:q]];
        
    }
    return final;
}

-(Fraction*)copyWithZone:(NSZone *)zone {
    
    Fraction *f = [[Fraction alloc] init];
    f.numerator = self.numerator;
    f.denominator = self.denominator;
    f.minus = self.minus;
    
    return f;
}

@end
