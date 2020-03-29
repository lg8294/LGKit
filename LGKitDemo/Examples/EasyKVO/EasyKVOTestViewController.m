//
//  KVOTestViewController.m
//  test
//
//  Created by lg on 2017/11/24.
//

#import "EasyKVOTestViewController.h"
#import <LGKit/NSObject+LGEasyKVO.h>
#import "EasyKVOTestObj.h"

@interface EasyKVOTestViewController ()

@property (nonatomic, strong) EasyKVOTestObj *p;

@property (nonatomic, weak) IBOutlet UILabel *label1;
@property (nonatomic, weak) IBOutlet UILabel *label2;

@end

@implementation EasyKVOTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    EasyKVOTestObj *p1 = [[EasyKVOTestObj alloc] initWithName:@"老翁" age:25];
    EasyKVOTestObj *p2 = [[EasyKVOTestObj alloc] initWithName:@"人20" age:20];
    self.p = p1;
    p1.people = p2;
    
    [self updateLabel1WithName:p1.name age:p1.age];
    [self updateLabel2WithName:p2.name age:p2.age];
    
    __weak typeof(self) weakSelf = self;
    [p1 lg_addObserver:self forkeyPath:@"age" completionHandler:^(id  _Nonnull obj, id  _Nullable newValue, id  _Nullable oldValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        EasyKVOTestObj *p = (EasyKVOTestObj *)obj;
        [strongSelf updateLabel1WithName:p.name age:[newValue integerValue]];
    }];
    [p1 lg_addObserver:self forkeyPath:@"people" completionHandler:^(id obj, id newValue, id oldValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        EasyKVOTestObj *newP = (EasyKVOTestObj *)newValue;
        [strongSelf updateLabel2WithName:newP.name age:newP.age];
    }];
    [p1 lg_addObserver:self forkeyPath:@"people.name" completionHandler:^(id obj, id newValue, id oldValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        EasyKVOTestObj *p = (EasyKVOTestObj *)obj;
        [strongSelf updateLabel2WithName:newValue age:p.people.age];
    }];
}

- (void)updateLabel1WithName:(NSString *)name age:(NSInteger)age {
    [self.label1 setText:[NSString stringWithFormat:@"%@的年龄是%ld",name, (long)age]];
}

- (void)updateLabel2WithName:(NSString *)name age:(NSInteger)age {
    [self.label2 setText:[NSString stringWithFormat:@"%@的年龄是%ld", name, (long)age]];
}

- (IBAction)changeName:(id)sender {
    NSInteger age = arc4random()%100;
    _p.people.name = [@"人" stringByAppendingFormat:@"%ld", (long)age];
}

- (IBAction)changePeople:(id)sender {
    NSInteger age = arc4random()%100;
    _p.people = [[EasyKVOTestObj alloc] initWithName:[@"人" stringByAppendingFormat:@"%ld", (long)age] age:age];
}

- (IBAction)ageAdd:(id)sender {
    _p.age += 5;
}

@end
