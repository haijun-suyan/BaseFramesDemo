//
//  levelOneTableViewCell.m
//  下拉列表
//
//  Created by haijunyan on 16/5/30.
//  Copyright © 2016年 haijunyan. All rights reserved.
//

#import "PullDownTableViewCell.h"

@implementation PullDownTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        self=[[PullDownTableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    //*****************自定义cell具有风格*****************
    self.backgroundColor=[UIColor brownColor];
    
    
    
    
    //*****************自定义cell具有风格*****************
    return self;
}
@end
