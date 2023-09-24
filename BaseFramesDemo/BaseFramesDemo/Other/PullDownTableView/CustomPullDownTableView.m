//
//  CustomPullDownTableView.m
//  pulldown
//
//  Created by haijunyan on 16/6/1.
//  Copyright © 2016年 haijunyan. All rights reserved.
//
#define kLevelOneTableCellHeight 40
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define HeaderHeight 30
#define HeaderWidth  [UIScreen mainScreen].bounds.size.width
#define kHeaderButtonWidth 44
#import "CustomPullDownTableView.h"
#import "PullDownTableViewCell.h"
@implementation CustomPullDownTableView
{
    UITableView* tableViewCommon;
    NSDictionary* sectionsDic;
    NSArray* rowsArr;
    NSMutableArray* _isOpen;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style toView:(UIView*)superView DataSource:(NSDictionary*)sectionDic{
    [self setDataSouce:sectionDic];
    sectionsDic=sectionDic;
    self=[super initWithFrame:frame style:style];
    if (!self) {
        self=[[CustomPullDownTableView alloc] initWithFrame:frame style:style];
    }
    self.delegate=self;
    self.dataSource=self;
    [superView addSubview:self];
    [self reloadData];
    [self registerClass:[PullDownTableViewCell class] forCellReuseIdentifier:@"pulldowncell"];
    
    return self;

}
#pragma mark---Initial
-(void)setDataSouce:(NSDictionary*)dictData{//词典资源
    _isOpen=[NSMutableArray arrayWithCapacity:[[dictData allKeys] count]];
    for (int i=0; i<[[dictData allKeys] count];i++) {
        _isOpen[i]=@"0";
    }
}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[sectionsDic allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numRowCell = 0;
    if ([_isOpen[section] integerValue]==0) {
        numRowCell=0;
        
    } else {
        
        numRowCell=[[sectionsDic objectForKey:[NSString stringWithFormat:@"%@",[[sectionsDic allKeys] objectAtIndex:section]]] count];
    }
    
    return numRowCell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PullDownTableViewCell* pullDownTableCell=[tableView dequeueReusableCellWithIdentifier:@"pulldowncell"];
    if (!pullDownTableCell) {
        pullDownTableCell=[[PullDownTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pulldowncell"];
    }
    
    pullDownTableCell.textLabel.text=[[sectionsDic objectForKey:[[sectionsDic allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    //pullDownTableCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//辅助展开指示器
    pullDownTableCell.backgroundColor=[UIColor clearColor];//透明色clearColor
    return pullDownTableCell;
}
#pragma mark -UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //自定义HeaderView
    UIView* headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,HeaderWidth,HeaderHeight)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,HeaderWidth-10,HeaderHeight)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    NSString* titleStr=[[sectionsDic allKeys] objectAtIndex:section];//标题内容
    //titleLabel.backgroundColor=[UIColor cyanColor];
    titleLabel.text =titleStr;
    [headView addSubview:titleLabel];
    headView.backgroundColor = [UIColor whiteColor];
    headView.tag = section +10;
    tableViewCommon=tableView;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureFinished:)];
    [headView addGestureRecognizer:tapGestureRecognizer];
    
    UIButton *jiantouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiantouBtn setFrame:CGRectMake(DEVICE_WIDTH-kHeaderButtonWidth, 0,kHeaderButtonWidth,HeaderHeight)];
    jiantouBtn.userInteractionEnabled = NO;
    [headView addSubview:jiantouBtn];
    if ([_isOpen[headView.tag-10] integerValue]==0) {
        [jiantouBtn setImage:[UIImage imageNamed:@"header_jiantou_mark"] forState:UIControlStateNormal];
    } else {
        [jiantouBtn setImage:[UIImage imageNamed:@"header_jiantou_nor"] forState:UIControlStateNormal];
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeaderHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kLevelOneTableCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRow%@",indexPath);
}
#pragma mark----UITapGestureRecognizer
-(void)tapGestureFinished:(UIGestureRecognizer*)ges{
    //手势判别零数组
    if ([_isOpen[ges.view.tag-10] integerValue]==0) {
        _isOpen[ges.view.tag-10]=[NSString stringWithFormat:@"%@",@"1"];
    }else{
        _isOpen[ges.view.tag-10]=[NSString stringWithFormat:@"%@",@"0"];
    }
    NSIndexSet* indexSet=[[NSIndexSet alloc]initWithIndex:ges.view.tag-10];
    [tableViewCommon reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
