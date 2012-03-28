//
//  BashfulPasswordTextField.h
//  BashfulPasswordTextField
//
//  Created by Jeremy Stuckey on 3/23/12.
//  Copyright (c) 2012 Jeremy Stuckey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BashfulPasswordTextField : UITextField
{
    BOOL isBashful;
    
    @private
    UIView *obscureView;
    NSInvocationOperation *hideOperation;
}

@property (nonatomic, assign) BOOL isBashful;

@end
