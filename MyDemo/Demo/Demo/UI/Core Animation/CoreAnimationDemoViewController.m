//
//  CoreAnimationDemoViewController.m
//  Demo
//
//  Created by 朱超鹏 on 2018/7/26.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "CoreAnimationDemoViewController.h"

@interface CoreAnimationDemoViewController ()

@property (nonatomic, strong) UIView *contentView;

@end

/*
 如果UIView检测到-drawRect: 方法被调用了，它就会为视图分配一个寄宿图，这个寄宿图的像素尺寸等于视图大小乘以 contentsScale的值。
 如果你不需要寄宿图，那就不要创建这个方法了，这会造成CPU资源和内存的浪费，这也是为什么苹果建议：如果没有自定义绘制的任务就不要在子类中写一个空的-drawRect:方法。
 */

@implementation CoreAnimationDemoViewController

@synthesize infoArr = _infoArr;

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentView];
    self.tableView.layer.borderColor    = [UIColor redColor].CGColor;
    self.tableView.layer.borderWidth    = 0.5;
    self.contentView.layer.borderColor  = [UIColor greenColor].CGColor;
    self.contentView.layer.borderWidth  = 0.5;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame    = CGRectMake(0, 0, self.view.width, 200);
    self.contentView.frame  = CGRectMake(0, self.tableView.bottom, self.view.width, self.view.height - self.tableView.height);
    UIView *view            = [self.contentView viewWithTag:999];
    if (view) {
        view.frame          = self.contentView.bounds;
    }
}

// ----------------------------------------------------------------------
#pragma mark - override
// ----------------------------------------------------------------------

- (BOOL)isMultipleGroups {
    return YES;
}

- (NSMutableArray *)infoArr {
    if (!_infoArr) {
        _infoArr = @[@{@"title": @"section1 图层树",
                       @"list": @[@"使用图层"]
                       },
                     @{@"title": @"section2 寄宿图",
                       @"list": @[@"认识寄宿图，通过设置寄宿图来显示一张图片",
                                  @"使用contentRect属性实现图片拼合（image sprites）",
                                  @"使用contentsCenter属性拉伸图片",
                                  @"CALayerDelegate"]
                       },
                     @{@"title": @"section3 图形几何学",
                       @"list": @[@"布局属性",
                                  @"锚点",
                                  @"坐标系转换",
                                  @"坐标系翻转",
                                  @"坐标系z轴",
                                  @"Hit Testing",
                                  @"自动布局"]
                       },
                     @{@"title": @"section4 视觉效果",
                       @"list": @[@"圆角",
                                  @"图层边框",
                                  @"阴影",
                                  @"图层蒙版",
                                  @"拉伸过滤"]
                       },
                     @{@"title": @"section5 变换",
                       @"list": @[@"仿射变换",
                                  @"3D变换 (基础变换)",
                                  @"3D变换（透视投影）",
                                  @"3D变换（其他）",
                                  @"固体对象"]
                       },
                     @{@"title": @"section6 专用图层",
                       @"list": @[@"CAShapeLayer",
                                  @"CATextLayer",
                                  @"CATransformLayer",
                                  @"CAGradientLayer",
                                  @"CAReplicatorLayer",
                                  @"CAScrollLayer",
                                  @"CATiledLayer",
                                  @"CAEmitterLayer",
                                  @"CAEAGLLayer",
                                  @"AVPlayerLayer"]
                       },
                     @{@"title": @"section7 隐式动画",
                       @"list": @[@"隐式动画",
                                  @"事务",
                                  @"完成块",
                                  @"图层行为",
                                  @"呈现与模型"]
                       },
                     @{@"title": @"section8 显式动画",
                       @"list": @[@"属性动画",
                                  @"动画组",
                                  @"过渡",
                                  @"对图层树的动画",
                                  @"自定义过渡动画",
                                  @"在动画过程中取消动画"]
                       },
                     @{@"title": @"section9 图层时间",
                       @"list": @[@"CAMediaTiming协议",
                                  @"手动动画"]
                       },
                     @{@"title": @"section10 缓冲",
                       @"list": @[@"动画速度",
                                  @"关键帧动画的动画速度",
                                  @"绘制缓冲曲线",
                                  @"根据缓冲曲线绘制关键帧动画的所有帧"],
                       },
                     @{@"title": @"section11 基于定时器的动画",
                       @"list": @[@"定时帧"]
                       },
                     @{@"title": @"section12 性能调优",
                       @"list": @[]
                       },
                     @{@"title": @"section13 高效绘图",
                       @"list": @[@"绘制矢量图形的2种方法",
                                  @"脏矩形"]
                       },
                     @{@"title": @"section14 图像IO",
                       @"list": @[@"加载和潜伏",
                                  @"缓存",
                                  @"文件格式"]
                       }
//                     @{@"title": @"section15 图层性能",
//                       @"list": @[@"隐式绘制",
//                                  @"离屏渲染",
//                                  @"混合和过渡绘制",
//                                  @"减少图层数量"]
//                       }
                     ].mutableCopy;
    }
    return _infoArr;
}

- (void)constructData {
    for (NSDictionary *infoDict in self.infoArr) {
        ZCPTableViewGroupDataModel *group = [[ZCPTableViewGroupDataModel alloc] init];
        NSArray *list = infoDict[@"list"];
        
        for (NSString *title in list) {
            ZCPSectionCellItem *item    = [[ZCPSectionCellItem alloc] initWithDefault];
            item.sectionTitle           = title;
            item.sectionTitlePosition   = ZCPSectionTitleLeftPosition;
            item.sectionTitleFont       = [UIFont systemFontOfSize:13.0f];
            item.cellHeight             = @(40.0f);
            [group.sectionCellItems addObject:item];
        }
        [self.tableViewAdaptor.items addObject:group];
    }
}

// ----------------------------------------------------------------------
#pragma mark - ZCPGroupListTableViewAdaptorDelegate
// ----------------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section objectForHeader:(id)object {
    return 20.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section objectForHeader:(id)object {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, self.tableView.width, 20);
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.infoArr[section][@"title"];
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectObject:(id<ZCPTableViewCellItemBasicProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class viewCls   = NSClassFromString([NSString stringWithFormat:@"CASection%liDemo", indexPath.section + 1]);
    SEL sel         = NSSelectorFromString([NSString stringWithFormat:@"demo%li", indexPath.row + 1]);
    
    // remove old view
    UIView *oldView = [self.contentView viewWithTag:999];
    [oldView removeFromSuperview];

    // add new view
    UIView *newView = [[viewCls alloc] initWithFrame:self.contentView.bounds];
    newView.tag = 999;
    [self.contentView addSubview:newView];

    // invoke method
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[newView methodSignatureForSelector:sel]];
    invocation.target = newView;
    invocation.selector = sel;
    [invocation invoke];
}

// ----------------------------------------------------------------------
#pragma mark - getters and setters
// ----------------------------------------------------------------------

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

@end
