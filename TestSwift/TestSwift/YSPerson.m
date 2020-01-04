//
//  YSPerson.m
//  TestSwift
//
//  Created by 张延深 on 2020/1/2.
//  Copyright © 2020 张延深. All rights reserved.
//

#import "YSPerson.h"
#import "TestSwift-Swift.h"

int sum(int a, int b) { return a + b; }
void testSwift() {
//    YSCar *car = [[YSCar alloc] initWithPrice:10.5 band:@"BMW"];
//    NSLog(@"%@", car);
//    car.price = 20.5;
//    car.name = @"Benz";
//    [car drive];
//    [YSCar run];
//    [car test];
}

@implementation YSPerson

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
    }
    return self;
}

+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name {
    return [[self alloc] initWithAge:age name:name];
}

- (void)run {
    NSLog(@"%zd %@ -run", _age, _name);
}

+ (void)run {
    NSLog(@"Person +run");
}

- (void)eat:(NSString *)food other:(NSString *)other {
    NSLog(@"%zd %@ -eat %@ %@", _age, _name, food, other);
}

+ (void)eat:(NSString *)food other:(NSString *)other {
    NSLog(@"Person +eat %@ %@", food, other);
}

@end
