//
//  CALSettingsController.m
//  Calc
//
//  Created by Taomin Chang on 9/6/14.
//  Copyright (c) 2014 Taomin Chang. All rights reserved.
//

#import "CALSettingsController.h"

@interface CALSettingsController () {
    //private members
    NSUserDefaults *defaults;
}
@property (strong, nonatomic) IBOutlet UITextField *ratio1;
@property (strong, nonatomic) IBOutlet UITextField *ratio2;
@property (strong, nonatomic) IBOutlet UITextField *ratio3;
- (IBAction)onTap:(id)sender;
@end

@implementation CALSettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Settings";
        self->defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    //We should really consider change this to a map object so we can easily loop over all of them
    float ratio1 = [self->defaults floatForKey:@"ratio1"];
    if (ratio1 == 0) {
        ratio1 = 0.1;
    }
    self.ratio1.text = [NSString stringWithFormat:@"%0.2f", ratio1 * 100];
    
    float ratio2 = [self->defaults floatForKey:@"ratio2"];
    if (ratio2 == 0) {
        ratio2 = 0.15;
    }
    self.ratio2.text = [NSString stringWithFormat:@"%0.2f", ratio2 * 100];
    
    float ratio3 = [self->defaults floatForKey:@"ratio3"];
    if (ratio3 == 0) {
        ratio3 = 0.2;
    }
    self.ratio3.text = [NSString stringWithFormat:@"%0.2f", ratio3 * 100];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(id)sender {
    //sync defaults
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.view endEditing:YES];
    float ratio1 = [self.ratio1.text floatValue] / 100;
    float ratio2 = [self.ratio2.text floatValue] / 100;
    float ratio3 = [self.ratio3.text floatValue] / 100;
    [self->defaults setFloat:ratio1 forKey:@"ratio1"];
    [self->defaults setFloat:ratio2 forKey:@"ratio2"];
    [self->defaults setFloat:ratio3 forKey:@"ratio3"];
}

@end
