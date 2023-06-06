function psi_viewer( posSLs, psis,xCutoffSL, yCutoffSL )

    [~,~,nz] = size( posSLs );

    f = figure;
    ax(1) = gca;%subplot(1,2,1);
    im_h(1) = scatter( posSLs(:,1,1), posSLs(:,2,1), 50, calcColor(psis(:,1)),'filled');
   % ax(1).CLim =[0,1];
    ax(1).XLim =[0,xCutoffSL];
    ax(1).YLim =[0,yCutoffSL];
    axis(ax(1),'equal')
  %  colormap(ax(1),'copper')
%     ax(2) = subplot(1,2,2);
%     im_h(2) = scatter( posSLs(:,1,1), posSLs(:,2,1), 50,pi/3*angle(psis(:,1)),'filled');
%     ax(2).CLim =[0,1];
%     ax(2).XLim =[0,xCutoffSL];
%     ax(2).YLim =[0,yCutoffSL];
%     axis(ax(2),'equal')
%     colormap(ax(2),'hsv')
    %%% UIs
    % ui panels
    p1 = uipanel(f,'Position',[0,0,0.1,1]);

    % Add sliders
    slz = uicontrol(p1,'style','slider',...
        'Units','Normalized','position',[0.5,0,0.25,1]...
        ,'min', 1, 'max', nz,'Value', 1,'SliderStep',[1/nz 1/nz]);
    
    % Listen to slider values and change B & C
    addlistener([slz], 'Value', 'PostSet',...
        @(hObject,eventdata) update(ax,im_h,posSLs,psis, nz,slz));
    
    update(ax,im_h,posSLs,psis, nz,slz)
end


function update(ax,im_h,posSLs,psis, nz,slz)
    zslice = round(slz.Value);
    
    if zslice>nz
        slz.Value = nz;
    elseif zslice <1
        slz.Value = 1;
    end
    setSlice(im_h,zslice,posSLs,psis)
    setTitle(ax,zslice,nz)
end

function setTitle(ax,zslice,nz)
    title(ax,sprintf('%d/%d slice', zslice, nz));
end

function [rgb] = calcColor( psi )
    
    LAB = [65*abs(psi),...
           60*abs(psi).*cos(angle(psi)),...
           60*abs(psi).*sin(angle(psi))];
    rgb = lab2rgb(LAB);
    rgb( rgb > 1 ) = 1;
    

end

function setSlice(im_h,zslice,posSLs,psis)
    % Select image from image stack  by slider values
    set(im_h(1),'XData', posSLs(:,1,zslice))
    set(im_h(1),'YData', posSLs(:,2,zslice))
    set(im_h(1),'CData', calcColor(psis(:,zslice)))
%     set(im_h(2),'XData', posSLs(:,1,zslice))
%     set(im_h(2),'YData', posSLs(:,2,zslice))
%     set(im_h(2),'CData', pi/3*angle(psis(:,zslice)))
end