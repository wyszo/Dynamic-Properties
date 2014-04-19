
#import "Kiwi.h"
#import "NSObject+DynamicProperties.h"


@interface NSStringContainer : NSObject

@property (nonatomic, strong) NSString *firstString;
@property (nonatomic, strong) NSString *secondString;
@property (nonatomic, strong) NSString *thirdString;
@property (nonatomic, strong) NSString *fourthString;

@end


@implementation NSStringContainer
@end


SPEC_BEGIN(DynamicPropertiesSpec)

describe(@"NSStringContainer instance", ^{
    
    __block NSStringContainer *simpleObject;
    
    beforeAll(^{
        simpleObject = [NSStringContainer new];
        simpleObject.firstString = @"firstString!";
        simpleObject.secondString = @"secondString!";
        simpleObject.thirdString = nil;
        simpleObject.fourthString = [NSString new];
    });
    
    void (^testsForNSObjectNSString)(NSArray*) = ^(NSArray *properties){
        [[properties shouldNot] beNil];
        [[theValue(properties.count) should] equal:theValue(3)];
        [[properties[0] should] equal:simpleObject.firstString];
        [[properties[1] should] equal:simpleObject.secondString];
        [[properties[2] should] equal:simpleObject.fourthString];
    };
    
    context(@"when aseked for all NSObject properties", ^{
        __block NSArray *allNSObjectProperties;
        
        beforeEach(^{
            allNSObjectProperties = [simpleObject allNonemptyPropertiesOfClass:[NSObject class]];
        });
        
        it(@"should return [firstString, secondString, fourthString]", ^{
            testsForNSObjectNSString(allNSObjectProperties);
        });
    });
    
    
    context(@"when asked for all NSString properties", ^{
        __block NSArray *allNSStringProperties;
        
        beforeEach(^{
            allNSStringProperties = [simpleObject allNonemptyPropertiesOfClass:[NSString class]];
        });
        
        it(@"should return [firstString, secondString, fourthString]", ^{
            testsForNSObjectNSString(allNSStringProperties);
        });
    });
    
    
    context(@"when asked for all UIView properties", ^{
        __block NSArray *allUIViewProperties;
        
        beforeEach(^{
            allUIViewProperties = [simpleObject allNonemptyPropertiesOfClass:[UIView class]];
        });
        
        it(@"should return nil", ^{
            [[allUIViewProperties should] beNil];
        });
    });
});

SPEC_END