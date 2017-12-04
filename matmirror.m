function mirror = matmirror(mode,mat)

    % MATMIRROR returns the horizontal or vertical mirror of the input mat.
    % 返回输入矩阵的行/列镜像对称矩阵
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    dim=length(size(mat));
    [maxdepth,~]=max(size(mat));
    if mode=='c'
        if dim==2
            mirror=fliplr(mat);
        elseif dim==3
            mirror=zeros(size(mat,1),size(mat,2),size(mat,3));
            for ii=1:maxdepth
                mirror(:,:,ii)=fliplr(mat(:,:,ii));
            end
        end
    elseif mode=='r'
        if dim==2
            mirror=mat';
            mirror=fliplr(mirror);
            mirror=mirror';
        elseif dim==3
            mirror=zeros(size(mat,1),size(mat,2),size(mat,3));
            for ii=1:maxdepth
                mirror(:,:,ii)=mat(:,:,ii)';
                mirror(:,:,ii)=fliplr(mirror(:,:,ii));
                mirror(:,:,ii)=mirror(:,:,ii)';
            end
        end
    end
    
end

