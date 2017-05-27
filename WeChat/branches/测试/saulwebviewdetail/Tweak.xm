
%hook YYUIWebView

- (void)webViewDidFinishLoad:(id)arg1
{
%orig;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSString *currentURL = [arg1 stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
        NSString * postTime = @"nil";
        NSString * readCount = @"nil";
        NSString * praiseCount = @"nil";
        // 发布时间
        NSString * time = @"<em id=\"post-date\" class=\"rich_media_meta rich_media_meta_text\">";
        if ([currentURL rangeOfString:time].location != NSNotFound) {
            NSArray *array = [currentURL componentsSeparatedByString:time];
            NSString * releaseTime = [array[1] substringToIndex:10];
            NSLog(@"发布时间为：%@",releaseTime);
            postTime = releaseTime;
        }

        // 阅读总数
        NSString * count = @"<span id=\"readNum3\">";
        if ([currentURL rangeOfString:count].location != NSNotFound) {
            NSArray *array = [currentURL componentsSeparatedByString:count];
            NSArray * lastCount = [array[1] componentsSeparatedByString:@"</span></div>"];
            NSLog(@"阅读数为：%@",lastCount[0]);
            readCount = lastCount[0];
        }

        // 文章点赞数
        NSString * praise = @"<i class=\"icon_praise_gray\"></i><span class=\"praise_num\" id=\"likeNum3\">";
        if ([currentURL rangeOfString:praise].location != NSNotFound) {
            NSArray *array = [currentURL componentsSeparatedByString:praise];
            NSArray * praiseC = [array[1] componentsSeparatedByString:@"</span>"];
            NSLog(@"点赞数为：%@",praiseC[0]);
            praiseCount = praiseC[0];
        }
        if (![postTime isEqual:@"nil"] && ![readCount isEqual:@"nil"] && ![praiseCount isEqual:@"nil"]) {
            NSString * totalString = [NSString stringWithFormat:@"发布时间为：%@\n阅读总数为：%@\n点赞数为：%@",postTime,readCount,praiseCount];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:totalString delegate:nil cancelButtonTitle:@"done" otherButtonTitles:nil];
            [alert show];
        }


        NSLog(@"HTML：%@",currentURL);

    });
}
%end
