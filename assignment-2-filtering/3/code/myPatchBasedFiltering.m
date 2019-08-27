function filteredImage = myPatchBasedFiltering(corruptImage, windowSize, patchSize, sigma)
% Function for patch based filtering

    filteredImage = zeros(size(corruptImage));
    [R,C] = size(corruptImage);
    halfWindowSize = floor(windowSize/2);
    halfPatchSize = floor(patchSize/2);
    
    for r=1:R
        fprintf("r = %d\n",r);
        % Find top and bottom of window and patch around current pixel
        patchTop = max(1, r-halfPatchSize);
        patchBottom = min(R, r+halfPatchSize);
        windowTop = max(1, r-halfWindowSize);    
        windowBottom = min(R, r+halfWindowSize);   
        
        for c=1:C
            % Find left and right of window and patch around current pixel
            patchLeft = max(1, c-halfPatchSize);
            patchRight = min(C, c+halfPatchSize);
            windowLeft = max(1, c-halfWindowSize);
            windowRight = min(C, c+halfWindowSize);
            
            window = corruptImage(windowTop:windowBottom,windowLeft:windowRight);
            weights = zeros(size(window));
            
            % Loop around the window
            for r1=windowTop:windowBottom
                % Calculate top and bottom of patch around other pixel
                patch1Top = max(1, r1-halfPatchSize);
                patch1Bottom = min(R, r1+halfPatchSize);
                
                for c1=windowLeft:windowRight
                    % Calculate left and right of patch around other pixel
                    patch1Left = max(1, c1-halfPatchSize);
                    patch1Right = min(C, c1+halfPatchSize);
                    
                    % Choose the size acc to shorter of the patches
                    dt = min(r-patchTop, r1-patch1Top);
                    db = min(patchBottom-r, patch1Bottom-r1);
                    dl = min(c-patchLeft, c1-patch1Left);
                    dr = min(patchRight-c, patch1Right-c1);
                    
                    % Compute the patches
                    patch = corruptImage(r-dt:r+db, c-dl:c+dr);
                    patch1 = corruptImage(r1-dt:r1+db, c1-dl:c1+dr);
                    
                    % Calculate weight using distance between patches
                    w = exp(-sum(sum((patch-patch1).^2))/sigma^2);
                    % Use mask to make patch isoropic
                    w = w * exp(-((r1-r)^2+(c1-c)^2)/100);
                    % Assign the weight in matrix
                    weights(r1-windowTop+1, c1-windowLeft+1) = w;                    
                end
            end
            
            % Normalise the weight matrix
            weights = weights / sum(sum(weights));
            
            filteredImage(r,c) = sum(sum(weights .* window));
         end
    end
     
end