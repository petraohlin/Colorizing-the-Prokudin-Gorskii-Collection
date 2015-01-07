function [ imgOffset ] = offset( firstImage, secondImage )
%SHIFT Calculates the offset needed between two images


firstImage = double(firstImage);
secondImage = double(secondImage);

min = inf; %First result must be less than infinity

%Find the smallest offset of an 10x10 area by sum squared difference
for x = -10:10
    for y = -10:10 
        temp = circshift(firstImage, [x y]);
        sumSquaredDifferenses = sum(sum((secondImage-temp).^2));
        if sumSquaredDifferenses < min
            min = sumSquaredDifferenses;
            imgOffset = [x y];
        end
    end
end

end

