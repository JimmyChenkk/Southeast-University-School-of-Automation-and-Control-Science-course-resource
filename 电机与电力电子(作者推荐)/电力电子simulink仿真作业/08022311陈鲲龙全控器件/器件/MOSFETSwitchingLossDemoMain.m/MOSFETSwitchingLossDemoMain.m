% MOSFET Switching Loss demonstrates switching power loss due to
% the turn-on delay time, rise time, on time, turn-off delay time and fall time.
% User can enter the parameters based on datasheet to see how these
% parameters affected the power loss.
%
% Written by Rodney Tan (PhD)
% Version 1.00 (Jan 2021)
% Version 2.00 (Oct 2024) Allow user to set switching frequency and duty cycle
%                         Taken all switching losses into account
function MOSFETSwitchingLossDemoMain

    figure('Resize','off','NumberTitle','off','Name',...
           'MOSFET Switching Loss Demo');
    
    uicontrol('Style', 'text', 'String', 'VDD (V)','backgroundcolor','w',...
              'Position', [140 160 50 20],'horizontalAlignment', 'left');
    hVDD=uicontrol('Style', 'edit', 'String','28',...
                   'Position', [190 160 35 20],'Callback',@SwitchingLoss); 
    uicontrol('Style', 'text', 'String', 'RDS (Ω)','backgroundcolor','w',...
              'Position', [140 140 50 20],'horizontalAlignment', 'left');
    hRDS=uicontrol('Style', 'edit', 'String','0.0175',...
                   'Position', [190 140 35 20],'Callback',@SwitchingLoss);
    uicontrol('Style', 'text', 'String', 'ID (A)','backgroundcolor','w',...
              'Position', [140 120 50 20],'horizontalAlignment', 'left');
    hID=uicontrol('Style', 'edit', 'String','25',...
                   'Position', [190 120 35 20],'Callback',@SwitchingLoss);
    uicontrol('Style', 'text', 'String', 'IDSS (uA)','backgroundcolor','w',...
              'Position', [140 100 50 20],'horizontalAlignment', 'left');
    hIDSS=uicontrol('Style', 'edit', 'String','25',...
                   'Position', [190 100 35 20],'Callback',@SwitchingLoss);
    
    uicontrol('Style', 'text', 'String', 'Tdon (ns)','backgroundcolor','w',...
              'Position', [240 160 50 20],'horizontalAlignment', 'left');
    htdon=uicontrol('Style', 'edit', 'String','12',...
                   'Position', [290 160 35 20],'Callback',@SwitchingLoss); 
    uicontrol('Style', 'text', 'String', 'Trise (ns)','backgroundcolor','w',...
              'Position', [240 140 50 20],'horizontalAlignment', 'left');
    htr=uicontrol('Style', 'edit', 'String','60',...
                   'Position', [290 140 35 20],'Callback',@SwitchingLoss);
    uicontrol('Style', 'text', 'String', 'Tdoff (ns)','backgroundcolor','w',...
              'Position', [240 120 55 20],'horizontalAlignment', 'left');
    htdoff=uicontrol('Style', 'edit', 'String','44',...
                   'Position', [290 120 35 20],'Callback',@SwitchingLoss);
    uicontrol('Style', 'text', 'String', 'Tfall (ns)','backgroundcolor','w',...
              'Position', [240 100 50 20],'horizontalAlignment', 'left');
    htf=uicontrol('Style', 'edit', 'String','45',...
                   'Position', [290 100 35 20],'Callback',@SwitchingLoss);           
    
    uicontrol('Style', 'text', 'String', 'Sw Freq (kHz)','backgroundcolor','w',...
              'Position', [340 160 100 20],'horizontalAlignment', 'left');
    hfsw=uicontrol('Style', 'edit', 'String','10',...
                   'Position', [420 160 35 20],'Callback',@SwitchingLoss);
    uicontrol('Style', 'text', 'String', 'Duty Cycle (%)','backgroundcolor','w',...
              'Position', [340 140 100 20],'horizontalAlignment', 'left');
    hd=uicontrol('Style', 'edit', 'String','60',...
                   'Position', [420 140 35 20],'Callback',@SwitchingLoss);
    hPloss = uicontrol('Style', 'text', 'String', 'Power Loss','backgroundcolor','w',...
              'Position', [340 100 120 20],'horizontalAlignment', 'left'); 
    
    SwitchingLoss;
    
    function SwitchingLoss(~,~)
        
        VDD = str2double(get(hVDD,'String'));
        RDS = str2double(get(hRDS,'String'));
        ID = str2double(get(hID,'String'));
        IDSS = str2double(get(hIDSS,'String'));
        tdon = str2double(get(htdon,'String'));
        tr = str2double(get(htr,'String'));
        tdoff = str2double(get(htdoff,'String'));
        tf = str2double(get(htf,'String'));
        fsw = str2double(get(hfsw,'String'))*1e3;
        d = str2double(get(hd,'String'))/100;

        StartTime = 50;
        VGS = 10;
        
        % VGS Waveform
        VgStart = zeros(1,StartTime);
        VgWidth(1:1000) = VGS;
        VgEnd = zeros(1,150);
        Vgt = [VgStart,VgWidth,VgEnd];
        % ID Waveform
        IStart = zeros(1,StartTime+tdon); 
        Irise = (ID/tr).*(1:tr);
        IDon(1:1050+tdoff-length(IStart)-tr) = ID; 
        Ifall = (-(ID/tf).*(1:tf))+ID; 
        IEnd = zeros(1,1200-tf-length(IDon)-tr-length(IStart)); 
        IDt = [IStart,Irise,IDon,Ifall,IEnd];
        % VDS Waveform
        VStart(1:StartTime+tdon) = VDD;
        Vfall = (-(VDD/tr).*(1:tr))+VDD+(ID*RDS);
        VDSon(1:1050+tdoff-length(VStart)-tr)= ID*RDS;
        Vrise = (VDD/tf).*(1:tf);
        VEnd(1:1200-tf-length(VDSon)-tr-length(VStart))=VDD;
        VDSt = [VStart,Vfall,VDSon,Vrise,VEnd];

        
        subplot(2,1,1);
        cla;
        yyaxis left;
        plot(VDSt,'-b','linewidth',2);
        hold on;
        plot(Vgt,'-y','linewidth',2);
        hold off;
        ylabel('Voltage (V)');
        yyaxis right;
        plot(IDt,'-r','linewidth',2);
        ylabel('Current (A)');
        title('MOSFET Switching Waveform');
        legend('VDS','VGS','ID','Location','best');
        xlabel('Time');
        set(gca, 'XTick', []);
        
        % Switching Loss
        Pdon = VDD*IDSS*1e-6*tdon*1e-9*fsw; % Turn-On delay loss
        Pr = (VDD*ID*tr*1e-9*fsw)/2;        % Rise time loss
        ton = (d/fsw)-(tr*1e-9)-(tdon*1e-9);
        Pon = ID^2*RDS*ton*fsw;             % On time loss
        Pdoff = ID^2*RDS*tdoff*1e-9*fsw;    % Turn-Off delay loss
        Pf = (VDD*ID*tf*1e-9*fsw)/2;        % Fall time loss
        toff = ((1-d)/fsw)-(tf*1e-9)-(tdoff*1e-9);
        Poff = VDD*IDSS*1e-6*toff*fsw;      % Off time loss
        Ploss = Pdon + Pr + Pon + Pdoff + Pf + Poff;

        set(hPloss,'String',sprintf('Power Loss = %0.3f W',Ploss));
        subplot(2,1,2);
        Plosst = VDSt.*IDt;
        plot(Plosst,'k','linewidth',2);
        xlabel('Time');
        ylabel('Power (W)');
        title('Switching Power Loss Waveform');
        set(gca, 'XTick', []);
    end
end