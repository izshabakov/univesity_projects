function [max]=Error(Y,Yrl)
buf2=0;
for i=2:length(Y)
    buf=abs(Yrl(i)-Y(i));
    if buf>buf2
       buf2=buf;
    end
end
max=buf2;
end
