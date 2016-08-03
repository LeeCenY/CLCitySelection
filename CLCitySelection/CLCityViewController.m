//
//  CLCityViewController.m
//  CLCitySelection
//
//  Created by nil on 16/8/4.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLCityViewController.h"
#import "CLCityModel.h"

@interface CLCityViewController () <UITableViewDelegate,UITableViewDataSource>

/** 左 */
@property (nonatomic, strong) UITableView *leftTable;
/** 右 */
@property (nonatomic, strong) UITableView *rightTable;
/** 省份数据源（左） */
@property (nonatomic, copy) NSMutableArray *dataSource;
/** 城市数据源（右） */
@property (nonatomic,copy) NSArray *cityDataSource;
/** 省份 */
@property (nonatomic, copy) NSString *province;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 记录点击第几行 */
@property (nonatomic, assign) NSUInteger leftSelected;
/** block */
@property (nonatomic,copy) CityBlock cityInfo;

@end

@implementation CLCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.leftTable];
    [self.view addSubview:self.rightTable];
    
    //plist 文件与字典转模型
    self.dataSource =[CLCityViewController cityList:[CLCityViewController plist]];
    
    //点击第一行
    [self tableView:self.leftTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //选中第一行
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftTable) {
        return self.dataSource.count;
    }else {
        return self.cityDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: self.leftTable]) {
        
        static NSString *leftCellID = @"leftCellID";
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:leftCellID];
        if (!leftCell) {
            leftCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellID];
        }
        CLCityModel *cityModel = self.dataSource[indexPath.row];
        leftCell.textLabel.text = cityModel.state;
        return leftCell;
    }else {
        
        static NSString *rightCellID = @"rightCellID";
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightCellID];
        if (!rightCell) {
            rightCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightCellID];
        }
        rightCell.textLabel.text = self.cityDataSource[indexPath.row];
        return rightCell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: self.leftTable]) {
        
        CLCityModel *cityModel = self.dataSource[indexPath.row];
        //把左边点击的那行的城市添加在一个城市数据源（右）里面
        self.cityDataSource = cityModel.cities;
        self.province = cityModel.state;
        [self.rightTable reloadData];
        
    }else {
        
        CLCityModel *cityModel = self.cityDataSource[indexPath.row];
        self.city =(NSString *)cityModel;
        self.cityInfo(self.province, self.city);
    }
}

#pragma mark - 公开方法
-(void)getCityInfo:(CityBlock)block {
    _cityInfo = block;
}

#pragma mark - 私有方法
//加载城市 plist文件
+ (NSArray *)plist {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *cityList = [NSArray arrayWithContentsOfFile:plistPath];
    return cityList;
}

//字典转模型
+(NSMutableArray *)cityList:(NSArray *)cityList {
    
    NSMutableArray *dictArray = [NSMutableArray array];
    for (NSDictionary *dict in cityList) {
        CLCityModel *city = [CLCityModel cityWithDict:dict];
        [dictArray addObject:city];
    }
    return dictArray;
}

#pragma mark - 懒加载
- (UITableView *)leftTable {
    
    if (!_leftTable) {
        
        _leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/4, self.view.frame.size.height ) style:UITableViewStylePlain];
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
    }
    return _leftTable;
}

- (UITableView *)rightTable {
    if (!_rightTable) {
        
        _rightTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/4, 64, self.view.frame.size.width-self.view.bounds.size.width/4 , self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
    }
    return _rightTable;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSArray *)cityDataSource {
    
    if (!_cityDataSource) {
        _cityDataSource = [NSArray array];
    }
    return _cityDataSource;
}


@end
