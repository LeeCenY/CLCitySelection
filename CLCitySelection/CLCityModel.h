//
//  CLCityModel.h
//  CLCitySelection
//
//  Created by nil on 16/8/4.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCityModel : NSObject
/** 城市 */
@property (nonatomic, copy) NSString *state;
/** 地区 */
@property (nonatomic, copy) NSArray *cities;

+(instancetype)cityWithDict:(NSDictionary *)dict;
@end
