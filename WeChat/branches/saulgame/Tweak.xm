
// NtOrderInfo

%hook NtOrderInfo
-(void)setProductName:(id)name {
%orig;
NSLog(@"\n\n\n setProductName  \n\n %@ \n\n  setProductName",name);
}

+(void)regProduct:(id)product Name:(id)name Price:(float)price Ratio:(int)ratio {
%orig;
NSLog(@"\n\n\n regProduct  \n\n %@ \n\n %@ \n\n %f \n\n %lld \n\n  regProduct",product,name,price,(long long)ratio);

}
//+(void)regProduct:(id)product Name:(id)name Price:(float)price Ratio:(int)ratio Bid:(id)bid;


%end


%hook ProductInfo

- (float)productPrice {

NSLog(@"\n\n\n productPrice  \n\n  productPrice");

return 0;
}
%end



