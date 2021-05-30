%% Visualization

% Indices
subplot(3,1,1)
plot(0.6*rand(1,50)+0.2, plist1.V1,'r.')
hold on
plot(0.6*rand(1,50)+1.2, plist2.V1,'r.')
plot(0.6*rand(1,50)+2.2, plist3.V1,'r.')
plot(0.6*rand(1,50)+3.2, plist4.V1,'r.')

plot(0.6*rand(1,50)+0.2, plist1.V2,'b.')
hold on
plot(0.6*rand(1,50)+1.2, plist2.V2,'b.')
plot(0.6*rand(1,50)+2.2, plist3.V2,'b.')
plot(0.6*rand(1,50)+3.2, plist4.V2,'b.')
plot([0,4],[0.05,0.05])

subplot(3,1,2)
AIC1=[aiclist1.V1, aiclist1.V2];
AIC1=AIC1-repmat(min(AIC1,[],2),[1,2]);
AIC1w=exp(-AIC1(:,1)/2)./sum(exp(-AIC1/2),2);
plot(0.6*rand(1,50)+0.2,AIC1w,'b.')

hold on
AIC2=[aiclist2.V1, aiclist2.V2];
AIC2=AIC2-repmat(min(AIC2,[],2),[1,2]);
AIC2w=exp(-AIC2(:,1)/2)./sum(exp(-AIC2/2),2);
plot(0.6*rand(1,50)+1.2,AIC2w,'b.')

AIC3=[aiclist3.V1, aiclist3.V2];
AIC3=AIC3-repmat(min(AIC3,[],2),[1,2]);
AIC3w=exp(-AIC3(:,1)/2)./sum(exp(-AIC3/2),2);
plot(0.6*rand(1,50)+2.2,AIC3w,'b.')

AIC4=[aiclist4.V1, aiclist4.V2];
AIC4=AIC4-repmat(min(AIC4,[],2),[1,2]);
AIC4w=exp(-AIC4(:,1)/2)./sum(exp(-AIC4/2),2);
plot(0.6*rand(1,50)+3.2,AIC4w,'b.')


BIC1=[biclist1.V1, biclist1.V2];
BIC1=BIC1-repmat(min(BIC1,[],2),[1,2]);
BIC1w=exp(-BIC1(:,1)/2)./sum(exp(-BIC1/2),2);
plot(0.6*rand(1,50)+0.2,BIC1w,'r.')

hold on
BIC2=[biclist2.V1, biclist2.V2];
BIC2=BIC2-repmat(min(BIC2,[],2),[1,2]);
BIC2w=exp(-BIC2(:,1)/2)./sum(exp(-BIC2/2),2);
plot(0.6*rand(1,50)+1.2,BIC2w,'r.')

BIC3=[biclist3.V1, biclist3.V2];
BIC3=BIC3-repmat(min(BIC3,[],2),[1,2]);
BIC3w=exp(-BIC3(:,1)/2)./sum(exp(-BIC3/2),2);
plot(0.6*rand(1,50)+2.2,BIC3w,'r.')

BIC4=[biclist4.V1, biclist4.V2];
BIC4=BIC4-repmat(min(BIC4,[],2),[1,2]);
BIC4w=exp(-BIC4(:,1)/2)./sum(exp(-BIC4/2),2);
plot(0.6*rand(1,50)+3.2,BIC4w,'r.')

subplot(3,1,3)
plot(0.6*rand(1,50)+0.2, ppplist1.V1,'g.')
hold on
plot(0.6*rand(1,50)+1.2, ppplist2.V1,'g.')
plot(0.6*rand(1,50)+2.2, ppplist3.V1,'g.')
plot(0.6*rand(1,50)+3.2, ppplist3.V1,'g.')
plot([0,4],[0.05,0.05])

% model recovery
mr_aic=[sum(aiclist1.V1>aiclist1.V2)/50, sum(aiclist2.V1<aiclist2.V2)/50, sum(aiclist3.V1<aiclist3.V2)/50, sum(aiclist4.V1<aiclist4.V2)/50];
mr_bic=[sum(biclist1.V1>biclist1.V2)/50, sum(biclist2.V1<biclist2.V2)/50, sum(biclist3.V1<biclist3.V2)/50, sum(biclist4.V1<biclist4.V2)/50];
mr_p_c=[sum(plist1.V2>.05)/50, sum(plist2.V2<.05)/50, sum(plist3.V2<.05)/50, sum(plist4.V2<.05)/50];
mr_ppp_c=[sum(ppplist1.V1>.05)/50, sum(ppplist2.V1<.05)/50, sum(ppplist3.V1<.05)/50, sum(ppplist4.V1<.05)/50];
mr_p_f=[sum(plist1.V1<.05)/50, sum(plist2.V1>.05)/50, sum(plist3.V1>.05)/50, sum(plist4.V1>.05)/50];
mr_p_cf=[sum(plist1.V1<.05 & plist1.V2>.05)/50, sum(plist2.V1>.05 & plist1.V2<.05)/50, sum(plist3.V1>.05 & plist1.V2<.05)/50, sum(plist4.V1>.05 & plist1.V2<.05)/50];
mr_anova=[sum(anovalist1.V1<.05)/50, sum(anovalist2.V1<.05)/50, sum(anovalist3.V1<.05)/50, sum(anovalist4.V1<.05)/50];

plot(mr_aic)
hold on
plot(mr_bic)
plot(mr_p_c)
plot(mr_p_f)
plot(mr_p_cf)
plot(mr_ppp_c)
plot(mr_anova)
