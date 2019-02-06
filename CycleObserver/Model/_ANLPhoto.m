// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ANLPhoto.m instead.

#import "_ANLPhoto.h"

const struct ANLPhotoAttributes ANLPhotoAttributes = {
	.data = @"data",
	.date = @"date",
};

const struct ANLPhotoRelationships ANLPhotoRelationships = {
	.measure = @"measure",
};

@implementation ANLPhotoID
@end

@implementation _ANLPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ANLPhoto" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ANLPhoto";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ANLPhoto" inManagedObjectContext:moc_];
}

- (ANLPhotoID*)objectID {
	return (ANLPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic data;

@dynamic date;

@dynamic measure;

@end

