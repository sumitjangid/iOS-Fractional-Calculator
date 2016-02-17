//
//  ViewController.m
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import "ViewController.h"

NSMutableArray *fraction;
NSMutableArray *numerators;
NSMutableArray *denominators;
NSMutableArray *operators;

Fraction* f;

@interface ViewController ()

@end

@implementation ViewController

{
    char op;
    int currentNumber;
    BOOL firstOperand, isNumerator;
    NSMutableString *displayString;
}

@synthesize display;

- (void)viewDidLoad {
    
    display.adjustsFontSizeToFitWidth = true;
    
    fraction =[[NSMutableArray alloc]init];
    
    numerators =[[NSMutableArray alloc]init];
    
    denominators =[[NSMutableArray alloc]init];
    
    operators =[[NSMutableArray alloc]init];
    
    f = [[Fraction alloc]init];
    
    firstOperand = YES;
    isNumerator = YES;
    
    displayString = [NSMutableString stringWithCapacity: 40];
}

-(void) processDigit: (int) digit
{
    currentNumber = currentNumber * 10 + digit;
    [displayString appendString: [NSString stringWithFormat: @"%i", digit]];
    display.text = displayString;
}


- (IBAction)clickDigit:(UIButton*)sender {
    
    int digit = sender.tag;
    
    [self processDigit:digit];
}

-(void) processOp: (char) theOp
{
    NSString *opStr;
    op = theOp;
    
    switch (theOp) {
        case '+':
            opStr = @" + ";
            break;
        case '-':
            opStr = @" - ";
            break;
        case '*':
            opStr = @" x ";
            break;
        case '/':
            opStr = @" ÷ ";
            break;
        default:
            break;
    }
    
    [self storeFracPart];
    firstOperand = NO;
    isNumerator = YES;
    
    [displayString appendString: opStr];
    display.text = displayString;
}

-(void) storeFracPart
{
    if(firstOperand) {
        if(isNumerator){
            
            f.numerator = currentNumber;
        }
        else{
            
            f.denominator = currentNumber;
            [fraction addObject:[f copy]];
            NSLog(@"length is %lu",(unsigned long)fraction.count);
            
        }
    }
    else if(isNumerator){
        
        f.numerator = currentNumber;
    }
    else {
        
        f.denominator = currentNumber;
        [fraction addObject:[f copy]];
        NSLog(@"length is %lu",(unsigned long)fraction.count);

        firstOperand = YES;
    }
    currentNumber = 0;
}


- (IBAction)clickPlus:(id)sender {
    
    [self processOp:'+'];
    [fraction addObject:@"+"];
    
}

- (IBAction)clickMinus:(id)sender {
    
    [self processOp:'-'];
    [fraction addObject:@"-"];
}

- (IBAction)clickMultiply:(id)sender {
    
    [self processOp: '*'];
    [fraction addObject:@"*"];
    
}

- (IBAction)clickDivide:(id)sender {
    
    [self processOp: '/'];
    [fraction addObject:@"/"];
}

- (IBAction)clickOver:(id)sender {
    
    [self storeFracPart];
    isNumerator = NO;
    [displayString appendString: @"/"];
    display.text = displayString;
}

- (IBAction)clickEquals:(id)sender {
    
    if(firstOperand == NO){
        [self storeFracPart];
        
        [displayString appendString:@" = "];
        display.text = displayString;
        
        currentNumber = 0;
        isNumerator = YES;
        firstOperand = YES;
       
        for (int i=0; i<[fraction count]; i++) {
            if([[fraction objectAtIndex:i] isKindOfClass: [Fraction class]]){
                
                Fraction* o = [fraction objectAtIndex:i];
                NSLog(@"Numerator is%d and Denominator is %d",o.numerator,o.denominator);
            } else {
                
                NSLog(@"Operator is %@",[fraction objectAtIndex:i]);
            }
            
        }
        
        
        ShuntingYardAlgorithm* s = [[ShuntingYardAlgorithm alloc]init];
        [s convertToPostfix:fraction];
        Fraction* ans = [s calculateAnswer];
        
        NSLog(@"answer is Numerator %d and Denomenator %d",ans.numerator,ans.denominator);
        [fraction removeAllObjects];
        [displayString appendString:[NSString stringWithFormat:@"%d/%d",ans.numerator,ans.denominator]];
        display.text = displayString;
    }
}

- (IBAction)clickClear:(id)sender {
    
    isNumerator = YES;
    firstOperand = YES;
    currentNumber = 0;
    
    [fraction removeAllObjects];
    
    [displayString setString:@""];
    display.text = displayString;
}



- (IBAction)squareRoot:(id)sender {
    NSLog(@"will calculate root");
    if(firstOperand == NO){
        [self storeFracPart];
        [displayString appendString:@" = "];
        display.text = displayString;
        
        currentNumber = 0;
        isNumerator = YES;
        firstOperand = YES;
        
        for (int i=0; i<[fraction count]; i++) {
            if([[fraction objectAtIndex:i] isKindOfClass: [Fraction class]]){
                
                Fraction* o = [fraction objectAtIndex:i];
                NSLog(@"Numerator is%d and Denominator is %d",o.numerator,o.denominator);
            } else {
                
                NSLog(@"object is %@",[fraction objectAtIndex:i]);
            }
        }
        
        ShuntingYardAlgorithm *c = [[ShuntingYardAlgorithm alloc]init];
        c.postfixNotaion = [c convertToPostfix: fraction];
        for(id i in c.postfixNotaion)
        {
            if([i isKindOfClass:[Fraction class]] )
            {
                Fraction *temp  = (Fraction*)i;
                NSLog(@"%d / %d", temp.numerator, temp.denominator);
            }
            else{
                NSString *temp = (NSString*)i;
                NSLog(@"%@", temp);
            }
        }
        
        Fraction *answer = [c calculateAnswer];
        if([fraction count]==1)
        {
            answer = [fraction objectAtIndex:0];
        }
        
        if([fraction count]==0)
        {
            Fraction *native = [[Fraction alloc]init];
            native.numerator=0;
            native.denominator=1;
            native.minusFlag=0;
            answer = native;
        }
        if((answer.numerator<0 && answer.denominator>0)|| (answer.numerator>0 && answer.denominator<0))
        {
            display.text = @"Minus Error";
            NSLog(@"roots of Numerator %d and Denominator %d", answer.numerator,answer.denominator);
            return;
        }
        int numeratorPartOne = 0,numeratorPartTwo = 0,denominatorPartOne = 0,denominatorPartTwo = 0;
        
        Fraction *r=[[Fraction alloc]init];
        int flag=0;
        
        NSMutableDictionary * answerofRoot = [r squareRoot:answer];
        for(id key in answerofRoot)
        {
            if(flag==0)
            {
                numeratorPartOne = [[[answerofRoot objectForKey:key] objectAtIndex:0] intValue];
                numeratorPartTwo = [[[answerofRoot objectForKey:key] objectAtIndex:1] intValue];
                flag++;
            }
            else
            {
                denominatorPartOne = [[[answerofRoot objectForKey:key] objectAtIndex:0] intValue];
                denominatorPartTwo =[[[answerofRoot objectForKey:key] objectAtIndex:1] intValue];
            }
        }
        
        if(denominatorPartOne == numeratorPartOne)
        {
            denominatorPartOne=1;
            
            numeratorPartOne=1;
        }
        if(denominatorPartTwo== numeratorPartTwo)
        {
            denominatorPartTwo=1;
            
            numeratorPartTwo=1;
            
        }
        [displayString appendString:[NSString stringWithFormat:@"%d√%d/%d√%d",numeratorPartOne,numeratorPartTwo,denominatorPartOne,denominatorPartTwo]];
        display.text = displayString;
        
        [fraction removeAllObjects];
    }
}

- (IBAction)PlusMinus:(id)sender {
    
    currentNumber = currentNumber * -1;
    NSLog(@"%d",currentNumber);
    int len = [self countNumbers:currentNumber];
    NSLog(@"%d",len);
    NSMutableString* modifiedString =[[displayString substringToIndex:[displayString length] - len] mutableCopy];
    [modifiedString appendString:[NSString stringWithFormat:@"%d",currentNumber]];
    displayString = modifiedString;
    display.text = displayString;
}

-(int)countNumbers:(int)number
{
    int numOfnumerator=0;
    int dummy1 = number;
    while(YES)
    {
        if((dummy1%10)==dummy1)
        {
            numOfnumerator++;
            break;
        }
        numOfnumerator++;
        dummy1=dummy1/10;
    }
    
    if(number > 0){
        
        return numOfnumerator + 1;
    }
    return numOfnumerator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end