//
//  ViewController.h
//  FractionalCalculator
//
//  Created by Sumit Jangid on 11/8/15.
//  Copyright © 2015 Sumit Jangid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"
#import "PriorityCheck.h"
#import "ShuntingYardAlgorithm.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;

-(void) processDigit: (int) digit;
-(void) processOp: (char) theOp;
-(void) storeFracPart;

- (IBAction)clickDigit:(id)sender;

- (IBAction)clickPlus:(id)sender;

- (IBAction)clickMinus:(id)sender;

- (IBAction)clickMultiply:(id)sender;

- (IBAction)clickDivide:(id)sender;

- (IBAction)clickOver:(id)sender;

- (IBAction)clickEquals:(id)sender;

- (IBAction)clickClear:(id)sender;

- (IBAction)squareRoot:(id)sender;

- (IBAction)PlusMinus:(id)sender;

@end

