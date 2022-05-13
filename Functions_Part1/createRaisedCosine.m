function op_t = createRaisedCosine(timePeriod, timeDelay, r, BW, f, t)
    op_f = raisedFilter(r, BW, f);
    [~, ind1] = min(abs(t-timePeriod*0.5 - timeDelay));  
    op_t = circshift(ifft(ifftshift(op_f)), ind1);
end