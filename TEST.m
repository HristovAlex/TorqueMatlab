x=Hella(533).Field;
y=Hella(533).A_X;

meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];
covfunc = {@covMaterniso, 3}; ell = 1; sf = 10; hyp.cov = log([ell; sf]);
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
  
mu = feval(meanfunc{:}, hyp.mean, x);

nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y);


z = linspace(7, 12, 1001)';
[m, s2, mprime, s2prime] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);
figure();
hold on; plot(z, mprime); plot(x, y, '+')
figure()
plot(diff(mprime),diff(m))
%%
covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);

hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, x, y);
exp(hyp2.lik)
nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x, y)

[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);
f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
fill([z; flipdim(z,1)], f, [7 7 7]/8)
hold on; plot(z, m); plot(x, y, '+')