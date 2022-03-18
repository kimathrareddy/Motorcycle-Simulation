function index = getIndexOfGraphValues(Vinit,speed, Array_limit)
    index = 1;
    while Vinit > speed(index) && Array_limit > index 
        index = index+1;
    end 
    if Array_limit == index 
        index = Array_limit;
    end
end

