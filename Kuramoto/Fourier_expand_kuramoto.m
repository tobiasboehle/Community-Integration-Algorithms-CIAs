function c = Fourier_expand_kuramoto(g, order)

c = zeros(2*order+1,1);



for k = 1:2*order+1
    alpha = k-order-1;
    fun = @(x) g(x).*exp(-1i*alpha*x);
    
    c(k) = 1/2/pi*integral(fun, 0,2*pi);
    
end





end