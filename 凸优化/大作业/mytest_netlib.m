presolve = 1;

if presolve
    src = '';
else
    src = '';
end
srcmat = 'data';

Probname = { '25fv47',  '80bau3b',  'adlittle',  'afiro',  'agg',  'agg2',  ... % 1 -- 6
    'agg3',  'bandm',  'beaconfd',  'bnl1',  'bnl2',  ... % 7 -- 12
    'boeing1',  'boeing2',  'bore3d',  'brandy',  'capri',  'cre-a',  ... % 13 -- 18
    'cre-b',  'cre-c',  'cre-d',  'cycle',  'czprob',  'd2q06c',  ... % 19 -- 24
    'd6cube',  'degen2',  'degen3',  'e226',  'etamacro',  ... % 25 -- 30
    'fffff800',  'finnis',  'fit1d',  'fit1p',  'fit2d',  'fit2p',  ... % 31 -- 36
     'ganges',    'greenbea',  'greenbeb',  'grow15',  ... % 37 -- 42
    'grow22',  'grow7',  'israel',  'kb2',  'ken-07',  'ken-11',  ... % 43 -- 48
    'ken-13',  'ken-18',  'lotfi',  'maros',  'maros-r7',  'modszk1',  ... % 49 -- 54
    'nesm',  'osa-07',  'osa-14',  'osa-30',  'osa-60',    ... % 55 -- 60
    'pds-02',  'pds-06',  'pds-10',  'pds-20',  'perold',  'pilot',  ... % 61 -- 66
    'pilot4',  'pilot87',  'pilot.ja',  'pilotnov',  'pilot.we',  'qap08',  ... % 67 -- 72
    'qap12',  'qap15',  'recipe',  'sc105',  'sc205',  'sc50a',  ... % 73 -- 78
    'sc50b',  'scagr25',  'scagr7',  'scfxm1',  'scfxm2',  'scfxm3',  ... % 79 -- 84
    'scorpion',  'scrs8',  'scsd1',  'scsd6',  'scsd8',  'sctap1',  ... % 85 -- 90
    'sctap2',  'sctap3',  'seba',  'share1b',  'share2b',  'shell',  ... % 91 -- 96
    'ship04l',  'ship04s',  'ship08l',  'ship08s',  'ship12l',  'ship12s',  ... % 97 -- 102
      'stair',  'standata',  'standgub',  'standmps',  'stocfor1',  ... % 103 -- 108
    'stocfor2',  'tuff',  'vtp_base',  'wood1p',  'woodw'};  ... % 109 -- 113
    

tol = 1e-5;
% tol = 1e-10;

nlen = length(Probname);
problist = 30:nlen;
% problist = [5];

num =0;
for dprob = 1:length(problist)
    pid  = problist(dprob);
    name = Probname{pid};
    if presolve; name = strcat(name,'pre'); end
%     fprintf('\n name: %s\n', name);
    load(strcat(srcmat,filesep,name,'.mat'),'Model');
%     n = size(A,2);
        if min(Model.ub) ~=inf || min(abs(Model.lb))~=0
           
            continue
        end
        fprintf('\n name: %s\n', name);
%         [A,b,c] = getAbc(Model);
%         n = size(A,2);
%         clear cvx
%     tic;
%     cvx_begin
%     cvx_solver mosek
%     variable x1(n)
%     minimize( c'*x1  )
%     subject to
%     A * x1 == b
%     x1 >= 0
%     cvx_end
%     t1 = toc;
    
%     tic
%     [x2,out2] = GRS(x1,A,b,c);
%     t3 = toc;
end