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
    Fraction *ans = [[Fraction alloc]init];
    if(self.denominator==op2.denominator)
    {
        ans.denominator = self.denominator;
        ans.numerator = self.numerator + op2.numerator;
        if( ans.numerator!=0 && ans.denominator!=0)
        {
            
            if(ans.numerator%ans.denominator==0)
            {
                ans.numerator = ans.numerator/ans.denominator;
                ans.denominator=1;
                
            }
            if(ans.denominator%ans.numerator==0)
            {
                ans.denominator= ans.denominator/ans.numerator;
                ans.numerator=1;
                
            }
        }
        return ans;
    }
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
        
        
        printf("Greatest common divisor of %d and %d = %d\n", x, y, gcd);
        printf("Least common multiple of %d and %d = %d\n", x, y, lcm);
        
        
        ans.numerator = (self.numerator*(lcm/self.denominator)) + (op2.numerator*(lcm/op2.denominator));
        
        ans.denominator = lcm;
        if(ans.numerator%ans.denominator==0)
        {
            ans.numerator = ans.numerator/ans.denominator;
            ans.denominator=1;
            
        }
        if(ans.denominator%ans.numerator==0)
        {
            ans.denominator= ans.denominator/ans.numerator;
            ans.numerator=1;
            
        }
        
        return ans;
    }
    
}
-(Fraction*)subtract:(Fraction*)op2
{
    Fraction *ans = [[Fraction alloc]init];
    if(self.denominator==op2.denominator)
    {
        ans.denominator = self.denominator;
        ans.numerator = self.numerator - op2.numerator;
        NSLog(@"lookin for crazy %d %d", self.numerator ,op2.numerator );
        if( ans.numerator!=0 && ans.denominator!=0)
        {
            
            if(ans.numerator%ans.denominator==0 && ans.numerator!=0)
            {
                ans.numerator = ans.numerator/ans.denominator;
                ans.denominator=1;
                
            }
            if(ans.denominator%ans.numerator==0 && ans.numerator!=0)
            {
                ans.denominator= ans.denominator/ans.numerator;
                ans.numerator=1;
                
            }
        }
        return ans;
    }
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
        
        printf("Greatest common divisor of %d and %d = %d\n", x, y, gcd);
        printf("Least common multiple of %d and %d = %d\n", x, y, lcm);
        ans.numerator = (self.numerator*(lcm/self.denominator)) - (op2.numerator*(lcm/op2.denominator));
        ans.denominator = lcm;
        
        if(ans.numerator%ans.denominator==0 && ans.numerator!=0)
        {
            ans.numerator = ans.numerator/ans.denominator;
            ans.denominator=1;
            
            
        }
        if(ans.denominator%ans.numerator==0 && ans.numerator!=0)
        {
            ans.denominator= ans.denominator/ans.numerator;
            ans.numerator=1;
            
        }
        
        return ans;
        
    }
    
    
}
-(Fraction*)divide:(Fraction*)op2
{
    Fraction *ans = [[Fraction alloc]init];
    ans.numerator = (self.numerator)*(op2.denominator);
    ans.denominator = (self.denominator)*(op2.numerator);
    if( ans.numerator!=0 && ans.denominator!=0)
    {
        if(ans.numerator%ans.denominator==0)
        {
            ans.numerator = ans.numerator/ans.denominator;
            ans.denominator=1;
            
        }
        if(ans.denominator%ans.numerator==0)
        {
            ans.denominator= ans.denominator/ans.numerator;
            ans.numerator=1;
            
        }
    }
    return ans;
    
}
-(Fraction*)multiply:(Fraction*)op2
{
    Fraction *ans = [[Fraction alloc]init];
    ans.numerator = (self.numerator)*(op2.numerator);
    ans.denominator = (self.denominator)*(op2.denominator);
    if( ans.numerator!=0 && ans.denominator!=0)
    {
        
        if(ans.numerator%ans.denominator==0 && ans.numerator!=0)
        {
            ans.numerator = ans.numerator/ans.denominator;
            ans.denominator=1;
            
        }
        if(ans.denominator%ans.numerator==0 && ans.numerator!=0)
        {
            ans.denominator= ans.denominator/ans.numerator;
            ans.numerator=1;
            
        }
    }
    return ans;
    
    
}
-(NSMutableDictionary*)squareRoot:(Fraction*)op2
{
    NSLog(@"inside square root method %d %d",op2.numerator,op2.denominator );
    NSMutableDictionary *final = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *rootOfNumerator = [self findRoot:op2.numerator];
    
    int numeratorPartOne=1;
    int numeratorPartTwo =1;
    
    for(id key in rootOfNumerator)
    {
        double ans;
        
        if([[rootOfNumerator objectForKey:key] intValue]%2==0)
        {
            ans = sqrt(pow([key intValue], [[rootOfNumerator objectForKey:key] intValue]));
            numeratorPartOne = numeratorPartOne*ans;
        }
        else
        {
            if(([[rootOfNumerator objectForKey:key] intValue]-1) != 0)
            {
                ans = sqrt(pow([key intValue], ([[rootOfNumerator objectForKey:key] intValue])-1));
                numeratorPartOne = numeratorPartOne*ans;
                numeratorPartTwo = numeratorPartTwo*[key intValue];
            }
            else
            {
                numeratorPartTwo = numeratorPartTwo*[key intValue];
            }
        }
    }
    [final setObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:numeratorPartOne],[NSNumber numberWithInt:numeratorPartTwo], nil] forKey:@"numerator"];
    NSLog(@"tammy %d %d",numeratorPartOne,numeratorPartTwo);
    NSMutableDictionary *rootOfDenominator = [self findRoot:op2.denominator];
    int denominatorPartOne=1;
    int denominatorPartTwo =1;
    
    for(id key in rootOfDenominator)
    {
        double ans;
        
        if([[rootOfDenominator objectForKey:key] intValue]%2==0)
        {
            ans = sqrt(pow([key intValue], [[rootOfDenominator objectForKey:key] intValue]));
            denominatorPartOne= denominatorPartOne*ans;
        }
        else
        {
            if(([[rootOfDenominator objectForKey:key] intValue]-1) != 0)
            {
                ans = sqrt(pow([key intValue], ([[rootOfDenominator objectForKey:key] intValue])-1));
                denominatorPartOne = denominatorPartOne*ans;
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
    
    NSMutableArray* allprime = [[NSMutableArray alloc]initWithObjects:nil];
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
    f.minusFlag = self.minusFlag;
    
    return f;
}

@end
