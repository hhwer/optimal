srcmat = 'data';
Rule.nu = 0.99;
Rule.eta1 = 0.0001;
Rule.eta2 = 0.5;
Rule.gamma1 = 2;
Rule.gamma2 = 10;
Rule.lambda = 1e-4;
Rule.epi = 1e-6;
% Probname = { 'maros-r7pre ', 'modszk1pre ', 'osa-07pre ', 'osa-14pre ', ...
%                         'osa-30pre ', 'osa-60pre ', 'qap08pre ', 'qap12pre ', ...
%                          'sc105pre ', 'sc205pre ', 'sc50apre ', ...
%                         'sc50bpre ', 'scrs8pre ', 'scsd1pre ', 'scsd6pre ', ...
%                         'scsd8pre ', 'sctap1pre ', 'sctap2pre ', 'sctap3pre ', ...
%                         'ship08lpre ', 'ship12lpre ', 'wood1ppre'};
Probname = {   'sc105pre ', 'sc205pre ', 'sc50apre ', ...
                        'sc50bpre ', 'scrs8pre ', 'scsd1pre ', 'scsd6pre ', ...
                         'sctap1pre ', 'wood1ppre'};
    

nlen = length(Probname);
problist = 1:nlen;
problist = nlen;
for dprob = 1:length(problist)
    pid  = problist(dprob);
    name = Probname{pid};
    load(strcat(srcmat,filesep,name,'.mat'),'Model');
        [A,b,c] = getAbc(Model);
        [m,n] = size(A);
        net(A,b,c,2);
end