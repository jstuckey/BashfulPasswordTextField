//
//  ViewController.h
//  Bashful Pass Demo
//
//  Created by Jeremy Stuckey on 3/23/12.
//  Copyright (c) 2012 Jeremy Stuckey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BashfulPasswordTextField.h"

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet BashfulPasswordTextField *bashfulPassTextField;
@property (retain, nonatomic) IBOutlet UISwitch *bashfulSwitch;
- (IBAction)switchValueChanged:(id)sender;
@end
