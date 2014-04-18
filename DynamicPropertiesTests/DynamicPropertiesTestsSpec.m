
#import "Kiwi.h"
#import "NSObject+DynamicProperties.h"


@interface SimpleClass : NSObject

@property (nonatomic, strong) NSString *firstString;
@property (nonatomic, strong) NSString *secondString;

@end


@implementation SimpleClass

- (id)init
{
    self = [super init];
    if (self) {
        _firstString = @"first one!";
        _secondString = @"second one!";
    }
    return self;
}

@end


SPEC_BEGIN(DynamicPropertiesSpec)

describe(@"SimpleClass", ^{
    
    __block SimpleClass *simpleObject;
    
    beforeAll(^{
        simpleObject = [SimpleClass new];
    });
    
    void (^testsForNSObjectNSString)(NSArray*) = ^(NSArray *properties){
        [[properties shouldNot] beNil];
        [[theValue(properties.count) should] equal:theValue(2)];
        [[properties[0] should] equal:simpleObject.firstString];
        [[properties[1] should] equal:simpleObject.secondString];
    };
    
    context(@"when aseked for all NSObject properties", ^{
        __block NSArray *allNSObjectProperties;
        
        beforeAll(^{
            allNSObjectProperties = [simpleObject allNonemptyPropertiesOfClass:[NSObject class]];
        });
        
        it(@"should return [firstString, secondString]", ^{
            testsForNSObjectNSString(allNSObjectProperties);
        });
    });
    
    
    context(@"when asked for all NSString properties", ^{
        __block NSArray *allNSStringProperties;
        
        beforeAll(^{
            allNSStringProperties = [simpleObject allNonemptyPropertiesOfClass:[NSString class]];
        });
        
        it(@"should return [firstString, secondString]", ^{
            testsForNSObjectNSString(allNSStringProperties);
        });
    });
    
    
    context(@"when asked for all UIView properties", ^{
        __block NSArray *allUIViewProperties;
        
        beforeAll(^{
            allUIViewProperties = [simpleObject allNonemptyPropertiesOfClass:[UIView class]];
        });
        
        it(@"should return nil", ^{
            [[allUIViewProperties should] beNil];
        });
    });
});

SPEC_END