//
//  CustomPullDownTableView.h
//  pulldown
//
//  Created by haijunyan on 16/6/1.
//  Copyright © 2016年 haijunyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPullDownTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style toView:(UIView*)superView DataSource:(NSDictionary*)sectionsDic;
@end
