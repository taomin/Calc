//
//  CALViewController.m
//  Calc
//
//  Created by Taomin Chang on 9/5/14.
//  Copyright (c) 2014 Taomin Chang. All rights reserved.
//

#import "CALViewController.h"
#import "CALSettingsController.h"

@interface CALViewController () {
    NSArray *tipRatios;
    NSUserDefaults *defaults;
}
@property (strong, nonatomic) IBOutlet UITextField *billamount;
@property (strong, nonatomic) IBOutlet UILabel *tipamount;
@property (strong, nonatomic) IBOutlet UILabel *totalamount;
@property (strong, nonatomic) IBOutlet UISegmentedControl *tipratio;
- (IBAction)onTap:(id)sender;
- (IBAction)saveDefaultTipRatio:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)loadDefaultTipRatio;
@end

@implementation CALViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
        self->tipRatios = @[@(0.1), @(0.15), @(0.2)];
        self->defaults = [NSUserDefaults standardUserDefaults];
        
    }
    return self;
}
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {

    float ratio = [self->tipRatios[self.tipratio.selectedSegmentIndex] floatValue];
    float bill = [self.billamount.text floatValue];
    float tip = bill * ratio;
    float total = bill + tip;
    self.tipamount.text = [NSString stringWithFormat:@"$%0.2f", tip];
    self.totalamount.text = [NSString stringWithFormat:@"$%0.2f", total];
}

- (void)loadDefaultTipRatio {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [self->defaults integerForKey:@"ratioIndex"];  // it will return 0 if no defaults set
    [self.tipratio setSelectedSegmentIndex:index];
    float ratio1 = [self->defaults floatForKey:@"ratio1"];
    float ratio2 = [self->defaults floatForKey:@"ratio2"];
    float ratio3 = [self->defaults floatForKey:@"ratio3"];
    self->tipRatios = @[@(ratio1), @(ratio2), @(ratio3)];
    
    for (int i=0, j=[self.tipratio numberOfSegments]; i<j; i++) {
        float ratio = [[self->tipRatios objectAtIndex:i] floatValue] * 100;
        [self.tipratio setTitle:[NSString stringWithFormat:@"%0.2f%%", ratio] forSegmentAtIndex:i];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self loadDefaultTipRatio];
    [self updateValues];
}

- (IBAction)saveDefaultTipRatio:(id)sender {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self->defaults setInteger:self.tipratio.selectedSegmentIndex forKey:@"ratioIndex"];
    [self->defaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self loadDefaultTipRatio];
    [self updateValues];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[CALSettingsController new] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
