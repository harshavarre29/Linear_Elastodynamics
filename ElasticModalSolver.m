function [p, e,t,D, w] = ElasticModalSolver()
[p,e,t]=initmesh('squareg'); % create mesh
E=1; % Young modulus
nu=0.3; % Poisson ratio
[mu,lambda]=Enu2Lame(E,nu);
[K,M]=ElasticAssembler(p,e,t,mu,lambda,@Force);
sigma = 1e-9;
[D,w]=eigs(K,M,10, sigma);
for i = 1: 10
    d = D(:, i);
    d1 = d(1:2:end);
    d2 = d(2:2:end);
    dd = [d1, d2];
    dd = dd';
    np = p + dd;
    np = np';
    [k, av] = convhull(np);
    figure(i), plot(np(k, 1), np(k, 2));
end
