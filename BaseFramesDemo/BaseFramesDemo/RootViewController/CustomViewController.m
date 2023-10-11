//  各方面技术综合平衡妥协
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
//原子结构里核资源一直被环绕的电子占用着(不会释放)
//atomic原子特性的属性:多读单写
//nonatomic非原子特性的属性:多读多写
//atomic原子特性的属性/nonatomic非原子特性的属性共同点： 访问读取getter事件皆可多线程(多线程动态读取)
//属性不同点
//atomic原子特性的属性：原子属性单写 间接写入setter事件具有隐式自旋锁(单线程同步执行(内存非动态分配(一直静态占用/内存消耗极大))）(虽然线程比较安全不会出现混乱)消耗大量内存(性能较低(不推荐))/抢占内存资源的属性(如购票属性、充值属性)
//nonatomic非原子特性的属性:非原子属性多写,间接写入setter事件不存在隐式自旋锁(多个线程动态写入/内存动态分配(动态内存将及时释放))/线程非安全但动态内存将及时释放,适合内存较小的移动设备
//(内存)锁(定)：意味着内存占用(相关动作完成前所占的内存不会被释放掉(可能造成内存的泄漏占用))/同一时间点只有单个线程访问
//锁现象、抢夺资源内存的业务命令码逻辑优先分配给后台服务端处理(降低客户端的内存压力)。
//在满足业务需求及性能活跃的前提下尽量避免多个线程条抢占同一片内存资源(避免数据混乱)。
//





#import "CustomViewController.h"

@interface CustomViewController ()
//属性关键字@property定义属性别名(栈区)直接沟通着由系统自动声明的getter读取/setter写入(桥接)事件(动作+堆区 组合)
//(栈区)属性别名 等效 动作+堆区 组合
//(单纯堆区)变量别名
// 类外通过getter/setter事件实现间接的读取/写入
// 属性别名所直接沟通的getter读取/setter写入(桥接)事件若属性别名的getter/setter2大事件同时进行实例重构则采取手动通过合成关键字@synthesize手动定义相应的堆区变量别名；   若只对属性别名相关的getter/setter2大事件中单个getter事件或单个setter事件进行单个实例重构则系统会自动合成一个私有的堆区变量以供直接访问(即不需手动关注)
//'_'下划线命名类构造器层的私有变量

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)UIButton *threadBtn;
@property(nonatomic,strong)UIButton *RTSenseBtn;
@property(nonatomic,strong)UIButton *abstractFactoryBtn;
@property(nonatomic,strong)UIButton *KVCUseRuleBtn;


@end

@implementation CustomViewController
//@synthesize(通过合成关键字@synthesize定义堆区变量构造出供(远程访问)读取/写入的内存堆区)
@synthesize name = _name;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.name; //‘.’执行链触发对应的间接读取事件
    self.name = @"颜海军";//‘.’执行链触发对应的间接写入事件
    [self.view addSubview:self.threadBtn];
    [self.threadBtn setFrame:CGRectMake(50, 50, 80, 40)];

    [self.view addSubview:self.RTSenseBtn];
    [self.RTSenseBtn setFrame:CGRectMake(50, 150, 250, 40)];

    [self.view addSubview:self.abstractFactoryBtn];
    [self.abstractFactoryBtn setFrame:CGRectMake(50, 250, 250, 40)];

    [self.view addSubview:self.KVCUseRuleBtn];
    [self.KVCUseRuleBtn setFrame:CGRectMake(50, 350, 250, 40)];


    
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

//    @synchronized (self) {
//        NSLog(@"%@",@"setter写入事件");
//        if (_name != name) {
//            _name = name;
//        }
//    }
}

//getter读取事件重构
- (UIButton *)threadBtn {
    if (!_threadBtn) {
        _threadBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    _threadBtn.backgroundColor = [UIColor cyanColor];
    _threadBtn.titleLabel.font = HarisFont(15);
    _threadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_threadBtn setTitle:@"多线程分析" forState:UIControlStateNormal];
    [_threadBtn setTitle:@"多线程分析" forState:UIControlStateHighlighted];
    [_threadBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateNormal];
    [_threadBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateHighlighted];
    [_threadBtn addTarget:self action:@selector(threadBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _threadBtn;
}

-(void)threadBtnClicked:(UIButton *)psender{
    ThreadViewController *vc = [ThreadViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)RTSenseBtn {
    if (!_RTSenseBtn) {
        _RTSenseBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    _RTSenseBtn.backgroundColor = [UIColor cyanColor];
    _RTSenseBtn.titleLabel.font = HarisFont(15);
    _RTSenseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_RTSenseBtn setTitle:@"RunTime框架的API使用场景" forState:UIControlStateNormal];
    [_RTSenseBtn setTitle:@"RunTime框架的API使用场景" forState:UIControlStateHighlighted];
    [_RTSenseBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateNormal];
    [_RTSenseBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateHighlighted];
    [_RTSenseBtn addTarget:self action:@selector(RTSenseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _RTSenseBtn;
}

-(void)RTSenseBtnClicked:(UIButton *)psender{
    RTSenseViewController*vc = [RTSenseViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)KVCUseRuleBtn {
    if (!_KVCUseRuleBtn) {
        _KVCUseRuleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    _KVCUseRuleBtn.backgroundColor = [UIColor cyanColor];
    _KVCUseRuleBtn.titleLabel.font = HarisFont(15);
    _KVCUseRuleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_KVCUseRuleBtn setTitle:@"KVC使用及原理" forState:UIControlStateNormal];
    [_KVCUseRuleBtn setTitle:@"KVC使用及原理" forState:UIControlStateHighlighted];
    [_KVCUseRuleBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateNormal];
    [_KVCUseRuleBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateHighlighted];
    [_KVCUseRuleBtn addTarget:self action:@selector(KVCUseRuleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _KVCUseRuleBtn;
}

-(void)KVCUseRuleBtnClicked:(UIButton *)psender{
    KVCUseRuleViewController*vc = [KVCUseRuleViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIButton *)abstractFactoryBtn {
    if (!_abstractFactoryBtn) {
        _abstractFactoryBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    _abstractFactoryBtn.backgroundColor = [UIColor cyanColor];
    _abstractFactoryBtn.titleLabel.font = HarisFont(15);
    _abstractFactoryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_abstractFactoryBtn setTitle:@"抽象工厂" forState:UIControlStateNormal];
    [_abstractFactoryBtn setTitle:@"抽象工厂" forState:UIControlStateHighlighted];
    [_abstractFactoryBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateNormal];
    [_abstractFactoryBtn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateHighlighted];
    [_abstractFactoryBtn addTarget:self action:@selector(abstractFactoryBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _abstractFactoryBtn;
}

-(void)abstractFactoryBtnClicked:(UIButton *)psender{
    AbstractFactoryViewController*vc = [AbstractFactoryViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}








@end
