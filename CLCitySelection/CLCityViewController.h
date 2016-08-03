//
//  CLCityViewController.h
//  CLCitySelection
//
//  Created by nil on 16/8/4.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityBlock) (NSString *province, NSString *city);
@interface CLCityViewController : UIViewController

- (void)getCityInfo:(CityBlock)block; //获取选中的城市
@end
