
#import "Kiwi.h"

SPEC_BEGIN(DynamicPropertiesSpec)

describe(@"sample test", ^{
    it (@"should pass", ^{
        [[[NSObject new] shouldNot] beNil];
    });
    
    it (@"should fail", ^{
        [[[NSObject new] should] beNil];
    });
});

SPEC_END