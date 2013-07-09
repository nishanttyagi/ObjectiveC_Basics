/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#define TAG_ACTIVITY_INDICATOR 149462

@implementation UIImageView (WebCache)


-(void) createActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle) activityStyle {
    
    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[self viewWithTag:TAG_ACTIVITY_INDICATOR];
    if (activityIndicator == nil) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        
        //calculate the correct position
        float width = activityIndicator.frame.size.width;
        float height = activityIndicator.frame.size.height;
        float x = (self.frame.size.width / 2.0) - width/2;
        float y = (self.frame.size.height / 2.0) - height/2;
        activityIndicator.frame = CGRectMake(x, y, width, height);
        
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.tag = TAG_ACTIVITY_INDICATOR;
        [self addSubview:activityIndicator];
    }
    
    [activityIndicator startAnimating];
    
}

-(void) removeActivityIndicator {
    
    UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[self viewWithTag:TAG_ACTIVITY_INDICATOR];
    if (activityIndicator) {
        [activityIndicator removeFromSuperview];
    }
    
}
- (void)setImageWithURL:(NSURL *)url
{
    [self createActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];

    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self createActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }
}
#if NS_BLOCKS_AVAILABLE
- (void)setImageWithURL:(NSURL *)url success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
{
    [self createActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];

    [self setImageWithURL:url placeholderImage:nil success:success failure:failure];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
{
    
    [self createActivityIndicatorWithStyle:UIActivityIndicatorViewStyleWhite];

    [self setImageWithURL:url placeholderImage:placeholder options:0 success:success failure:failure];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options success:success failure:failure];
    }
}
#endif

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
    [self removeActivityIndicator];
}

# pragma mark - Delegate

- (void)updateProgressView:(NSNumber *)progress {
	if ([progress floatValue] > 0) {
		OCProgress *prg = nil;
		if ([self viewWithTag:kSDWebImageProgressView] == nil) {
			CGRect r = CGRectMake(10, (self.frame.size.height / 2) - 10, self.frame.size.width - 20, 20);
			prg = [[OCProgress alloc] initWithFrame:r];
			prg.tag = kSDWebImageProgressView;
            prg.progressColor = [UIColor whiteColor];
            prg.progressRemainingColor = [UIColor clearColor];
            
			[self addSubview:prg];
            
		} else {
			prg = (OCProgress *)[self viewWithTag:kSDWebImageProgressView];
		}
		[prg setHidden:NO];
        prg.currentValue = [progress floatValue];
        
        if (prg.currentValue == 1.0) {
            [prg removeFromSuperview];
        }
	}
}

@end
