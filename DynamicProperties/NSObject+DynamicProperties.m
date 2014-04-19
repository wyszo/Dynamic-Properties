
#import "NSObject+DynamicProperties.h"
#import <objc/runtime.h>


@implementation NSObject (DynamicProperties)

- (NSArray *)allNonemptyPropertiesOfClass:(Class)aClass
{
	unsigned int count;
	objc_property_t *allProperties = class_copyPropertyList([self class], &count);
    NSArray *matchingProperties = [self allPropertiesOfType:aClass fromPropertyList:allProperties withPropertyListCount:count];
	free(allProperties);
	
    if (matchingProperties.count == 0) {
        matchingProperties = nil;
    }
    return matchingProperties;
}

- (NSArray *)allPropertiesOfType:(Class)aClass fromPropertyList:(objc_property_t *)allProperties withPropertyListCount:(unsigned int)allPropertiesCount
{
    NSMutableArray *matchingProperties = [NSMutableArray new];
    
	for (int i=0; i < allPropertiesCount; i++) {
		objc_property_t property = allProperties[i];
 
        id propertyInstance = [self instanceOfProperty:property];
        if ([propertyInstance isKindOfClass:aClass]) {
            [matchingProperties addObject:propertyInstance];
        }
	}
    return [matchingProperties copy];
}

- (id)instanceOfProperty:(objc_property_t)property
{
    NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
    return [self valueForKey:propertyName];
}

@end
