function c = Fourier_expand(eta, L, p, n)

cell_vec = mat2cell((2*p+1)*ones(n,1), ones(n,1));
c = zeros(cell_vec{:});

fun = @(x,y) eta(sqrt(x.^2 + y.^2));

abstol = 1e-10;
reltol = 1e-6;


if isempty(gcp('nocreate'))
    
    for i = 1:2*p+1
        for j = 1:2*p+1
            alpha = [i;j]-p-1;
            expo = @(x,y) exp(-1i *pi/L* (alpha(1) * x + alpha(2) * y));
            c(i,j) = 1/(2*L)^n * integral2(@(x,y) fun(x,y) .* expo(x,y), -L,L, -L,L, 'AbsTol', abstol, 'RelTol', reltol);
        end
    end
    
else
    
    parfor i = 1:2*p+1
        val_vec = zeros(1,2*p+1);
        for j = 1:2*p+1
            alpha = [i;j]-p-1;
            expo = @(x,y) exp(-1i *pi/L* (alpha(1) * x + alpha(2) * y));
            val_vec(j) = 1/(2*L)^n * integral2(@(x,y) fun(x,y) .* expo(x,y), -L,L, -L,L, 'AbsTol', abstol, 'RelTol', reltol);
        end
        c(i,:) = val_vec;
    end
    
end


end