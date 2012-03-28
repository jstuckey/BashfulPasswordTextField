//
//  BashfulPasswordTextField.m
//  BashfulPasswordTextField
//
//  Created by Jeremy Stuckey on 3/23/12.
//  Copyright (c) 2012 Jeremy Stuckey. All rights reserved.
//

#import "BashfulPasswordTextField.h"

@implementation BashfulPasswordTextField

@synthesize isBashful;

- (void)hideObscureView:(NSInvocationOperation *)op {
    // Only hide the obscure view when told by the most current operation
    // There could be multiple hide operations being invoked if the user types quickly
    if (op == hideOperation) {
        [obscureView setHidden:YES];
    }
}

- (void)textChanged:(NSNotification *)notification
{
    // Show/hide the obscure view
    [obscureView setHidden:!isBashful];
    
    // Check if the visible, plaintext password character should be hidden
    if (isBashful)
    {
        UITextField *textField = (UITextField *)[notification object];
        NSString *text = [textField text];
        
        // Check if text has been entered
        if ([text length]) 
        {
            // Get the width and position of the last character
            CGFloat charWidth = [[text substringFromIndex:([text length] - 1)] sizeWithFont:[self font]].width;
            CGRect caretFrame = [textField caretRectForPosition:[textField endOfDocument]];
            CGFloat charX = caretFrame.origin.x - charWidth;
            
            // Construct the new frame for the obscure view based on the character position and width
            [obscureView setFrame:CGRectMake(charX, 0, charWidth, obscureView.frame.size.height)];
            
            // Tell obscure view to redraw
            [obscureView setNeedsDisplay];
            
            // Clean up the previous hide operation
            if (hideOperation) {
                [hideOperation release];
                hideOperation = nil;
            }
            
            // Create a new invocation operation that will hide the obscure view
            hideOperation = [NSInvocationOperation alloc];
            [hideOperation initWithTarget:self selector:@selector(hideObscureView:) object:hideOperation];
            
            // Fire hide operation in about two seconds
            // This is about the amount of time the pasword character remains visible in plain text if the user does not type another character
            // If the user types quickly, the plaintext character is changed to a password character before the full ~2 seconds
            [NSTimer scheduledTimerWithTimeInterval:2.2
                                         invocation:[hideOperation invocation]
                                            repeats:NO];
        } else {
            [obscureView setHidden:YES];
        }
    }
}

#pragma mark - Memory Management

// Do init or doin' it?
- (void)doInit {
    // Set to show password characters
    [self setSecureTextEntry:YES];
    
    // Set to hide the last character by default
    [self setIsBashful:YES];
    
    // Create the view used to hide the visible password character
    obscureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
    [obscureView setBackgroundColor:[self textColor]];
    [self addSubview:obscureView];
    [self bringSubviewToFront:obscureView];
    [obscureView setHidden:YES];
    
    // Register to be notified when the field's text changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:self];
}

- (id)init {
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    [obscureView release];
    [hideOperation release];
}

@end
