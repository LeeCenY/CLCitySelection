//
//  CLCityModel.m
//  CLCitySelection
//
//  Created by nil on 16/8/4.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLCityModel.h"

@implementation CLCityModel

+ (instancetype)cityWithDict:(NSDictionary *)dict {
    
    CLCityModel *city = [[self alloc] init];
    [city setValuesForKeysWithDictionary:dict];
    return city;
    
}
@end
