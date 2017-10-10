x = 10.5;
y1 = round(x);
disp(y1); % 11

y2 = fix(x);
disp(y2); % 10

y3 = mod(x, 3);
disp(y3); % 1.5000

x_mtrx = [10 3 -6 9 5];
y4 = prod(x_mtrx);
disp(y4); % -8100

y5 = mean(x_mtrx);
disp(y5); % 4.200

y6 = abs(x_mtrx);
disp(y6); % [10 3 6 9 5];

y7 = exp(x_mtrx);
disp(y7); %  1.0e+04 *[2.2026 0.0020 0.0000 0.8103 0.0148]
