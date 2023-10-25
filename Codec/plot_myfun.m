% plots myfun(x,c) for x in [0..1] and c = 2

clf; % clears figure
x = 0:0.01:1;
c = 0.5;
for i = 1:4
    plot(myfun(x,c)) % adjust this line!
    title(['myfun(x,c); c= (0.5:0.5:',num2str(c)],')');
    xlabel('x');
    ylabel('myfun(x)');
    c = c + 0.5;
    hold ON
end

