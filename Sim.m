%% Simulation for PSYC214 mid-term assignment

clear
l0=.8; % loading
l1=[.8 .85 1.2 2]; % cross-loading size
% Specify loading matrices
L1=[l0, l0, l0, 0, 0, 0; 0, 0, 0, l0, l0, l0]';
L2=cell(1,length(l1));
for i=1:length(l1)
    L2{i}=[l1(i), l1(i), l1(i), 0, 0, 0; 0, 0, 0, l1(i), l1(i), l1(i)]';
end
L=[{L1}, L2]; % set of loading conditions
Nlat=size(L1, 2);
Nobs=size(L1,1);
% Specify vcov matrix for latent variables
r_lat=.4; % latent variable variance
lat_vcov=r_lat*ones(1,Nlat); % full connection
% Specify variances for observed variables
v_obs=.5;
obs_v=v_obs*ones(1,Nobs);
Nsample=200; % number of participants
Nrep=50; % number of replications
obs_all=cell(length(L),Nrep);
lat_all=cell(length(L),Nrep);
save_dir='/home/tianye/Matlab_WS/CFA';
cd(save_dir)
for r=1:Nrep
    for i=1:length(L)
        [obs_all{i,r}, lat_all{i,r}]=SimCFA(L{i},lat_vcov,obs_v,Nsample);
        filename=sprintf('cfa_%d_%d.txt',i,r);
        dlmwrite(filename, obs_all{i,r});
    end
end

% Check
for i=1:length(L)
    subplot(3,1,i)
    imagesc(corr([obs_all{i,3}, lat_all{i,3}]))
end

%% Parameter Recovery
for i=1:19
    x=randn(100,1)*0.2+i;
    plot(x,coef_2_3(i,:),'b.')
    hold on
end

%% RFX-BMS

m1.LLH=-fit_1_3(2,:)';
m1.BIC=fit_1_3(4,:)';
m1.DIC1=fit_1_3(5,:)';
m1.WAIC1=fit_1_3(7,:)';
m1.LME_GHM=-fit_1_3(13,:)';
m2.LLH=-fit_2_3(2,:)';
m2.BIC=fit_2_3(4,:)';
m2.DIC1=fit_2_3(5,:)';
m2.WAIC1=fit_2_3(7,:)';
m2.LME_GHM=-fit_2_3(13,:)';
m1.FitOptions.RFXBMS=1;
m2.FitOptions.RFXBMS=1;
m1.Criteria={'LLH','BIC','WAIC1','DIC1','LME_GHM'};
m2.Criteria=m1.Criteria;
MA_All={m1,m2};
MC_All=ModelComparison_BMW(MA_All);
config.Criteria='BIC';
%Figure=Visualization_BMW(MC_All{1},'ModelSelectionColormap',config);
A=[MC_All{1}.LLH.LLH_weight(:,1),MC_All{1}.BIC.BIC_weight(:,1),MC_All{1}.DIC1.DIC1_weight(:,1), MC_All{1}.WAIC1.WAIC1_weight(:,1), MC_All{1}.LME_GHM.LME_GHM_weight(:,1)];
B=[rand(100,1)+1, rand(100,1)+3, rand(100,1)+5, rand(100,1)+7, rand(100,1)+9];
for i=1:5
    plot(B(:,i)',A(:,i)','bl.')
hold on
box off
end
plot([0,11],[1 1])
plot([0,11],[0 0])
% for m=1:length(Modellist)
%     m1.LLH=zeros(Nsubj,1);
%     m1.AIC=zeros(Nsubj,1);
%     m1.AICc=zeros(Nsubj,1);
%     m1.BIC=zeros(Nsubj,1);
%     m1.WAIC1=zeros(Nsubj,1);
%     m1.WAIC2=zeros(Nsubj,1);
%     m1.DIC1=zeros(Nsubj,1);
%     m1.DIC2=zeros(Nsubj,1);
%     m1.DICs=zeros(Nsubj,1);
%     m1.LME_GHM=zeros(Nsubj,1);
%     m1.Param=[];
%     for e=1:length(Exptlist)
%         current_data=['IC_',Modellist{m},'_',Cond,'_',Exptlist{e}];
%         load(current_data)
%         m1.FitOptions.RFXBMS=1;
%         m1.Criteria={'LLH','AIC','AICc','BIC','WAIC1','WAIC2','DIC1','DIC2','DICs','LME_GHM'};
%         m1.Param=vertcat(m1.Param,a.Param);
%         m1.LLH((e-1)*10+1:e*10)=a.LLH;
%         m1.AICc((e-1)*10+1:e*10)=a.AICc;
%         m1.AIC((e-1)*10+1:e*10)=a.AIC;
%         m1.BIC((e-1)*10+1:e*10)=a.BIC;
%         m1.WAIC1((e-1)*10+1:e*10)=a.WAIC1;
%         m1.WAIC2((e-1)*10+1:e*10)=a.WAIC2;
%         m1.DIC1((e-1)*10+1:e*10)=a.DIC1;
%         m1.DIC2((e-1)*10+1:e*10)=a.DIC2;
%         m1.DICs((e-1)*10+1:e*10)=a.DICs;
%         m1.LME_GHM((e-1)*10+1:e*10)=a.LME_GHM;
%     end
%     MA_All{m}=m1;
% end
% MC_All=ModelComparison_BMW(MA_All,[0,0,1,1,2,2,1,1,2,2,0,0]);
