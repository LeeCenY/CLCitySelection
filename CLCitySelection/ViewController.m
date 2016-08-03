//
//  ViewController.m
//  CLCitySelection
//
//  Created by nil on 16/8/4.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "ViewController.h"
#import "CLCityViewController.h"

@interface ViewController ()

/** 省份 */
@property (nonatomic, copy) NSString *province;
/** 城市 */
@property (nonatomic, copy) NSString *city;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    CLCityViewController * c = [[CLCityViewController alloc] init];
    [c getCityInfo:^(NSString *province, NSString *city) {
        _province = province;
        _city =city;
        NSLog(@"%@ = %@",_province,_city);
    }];
    [self.navigationController pushViewController:c animated:YES];
}

@end
