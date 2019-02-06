// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLCurrentMeasure.m instead.

#import "_ANLCurrentMeasure.h"

const struct ANLCurrentMeasureRelationships ANLCurrentMeasureRelationships = {
	.measure = @"measure",
	.segment = @"segment",
};

@implementation ANLCurrentMeasureID
@end

@implementation _ANLCurrentMeasure

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLCurrentMeasure" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLCurrentMeasure";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLCurrentMeasure" inManagedObjectContext:moc_];
}

- (ANLCurrentMeasureID*)objectID {
	return (ANLCurrentMeasureID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic measure;

@dynamic segment;

@end

