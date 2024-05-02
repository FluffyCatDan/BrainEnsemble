function [angle ] = make_reference(train_x,train_l)

[ sig,ens ] = make_ensemble(train_x,train_l);
[b,a]=size(sig);
o=ones(1,b);
angle=zeros(1,a);
d=ens'*ens;
k=o*ens;
lan=-k/d;
ref=o+lan*ens';

for i=1:a
     angle(i)=acos(dot(sig(:,i),ref')/(norm(sig(:,i))*norm(ref')))*180/pi;
end

end

