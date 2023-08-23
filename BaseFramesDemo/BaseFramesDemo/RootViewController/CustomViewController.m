//
//  CustomViewController.m
//  BaseFramesDemo
//
//  Created by haijunyan on 2020/12/29.
//  Copyright © 2020 haijunyan. All rights reserved.
//  @implementation重量级构造器(本身实例区)
//属性别名 和 变量别名 2个不同的概念
//某些版本的系统库里面采用@synthesize关键字隐式(即@property关键字不仅产生属性本身的作用定义属性别名及getter/setter事件同时系统对应自动合成堆区变量) 已自动处理属性和变量间关联(不需手动关注)
//某些版本的系统库里面未自动处理属性和变量间关联(需手动关注属性和变量间关联)
//关键字研究
//@synchronous/ˈsɪŋkrənəs/ 同步(逻辑关系)
//@synthesize/ˈsɪnθəsaɪz/合成



#import "CustomViewController.h"

@interface CustomViewController ()
//属性关键字@property定义属性别名(栈区)直接沟通着由系统自动声明的getter读取/setter写入(桥接)事件(动作+堆区 组合)
//(栈区)属性别名 等效 动作+堆区 组合
//(单纯堆区)变量别名
// 类外通过getter/setter事件实现间接的读取/写入
// 属性别名所直接沟通的getter读取/setter写入(桥接)事件若属性别名的getter/setter2大事件同时进行实例重构则采取手动通过合成关键字@synthesize手动定义相应的堆区变量别名；   若只对属性别名相关的getter/setter2大事件中单个getter事件或单个setter事件进行单个实例重构则系统会自动合成一个私有的堆区变量以供直接访问(即不需手动关注)
//'_'下划线命名类构造器层的私有变量

@property(atomic,strong)NSString *name;

@end

@implementation CustomViewController
//@synthesize(通过合成关键字@synthesize定义堆区变量构造出供(远程访问)读取/写入的内存堆区)
@synthesize name = _name;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.name;
    self.name = @"颜海军";
    
}

//getter读取事件重构
- (NSString *)name {
    NSLog(@"%@",@"getter读取事件");
    if (_name != nil) {
        return _name;
    }
    return  @"";
}

//setter写入事件重构
- (void)setName:(NSString *)name {
    NSLog(@"%@",@"setter写入事件");
    if (_name != name) {
        _name = name;
    }




}

@end
