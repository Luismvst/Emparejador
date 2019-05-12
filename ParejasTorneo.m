fprintf("\nSistema de creacion de parejas de luis\n\n\n");
%fprintf("Desea inicializar? no-0, si-1\n");
%ini = input("");
ini=0;
pos=0;
e = 0.5;
%nombres = ["Luis";"GSI"; "Sepi"; "Samu"; "Jordi"; "Guille"; "Charly"; "Manu"; "Barru"; "Lazaro"; "Isma"; "Sarda"; "Rozas"; "Goiko"; "Victornado"; "Mario" ];
nombres = ["Luis";"GSI";  "Jordi"; "Guille"; "Lazaro"; "Isma"; "Goiko"; "Victornado" ];
r_global = [6	,	6,		7,			7,		6,		5	,	6,		7,		];
elegidas = ["Charly"; "Manu"; "Rozas"; "Sarda"; "Barru"; "Mario";"Sepi"; "Samu"];
r_elegidas = [10, 		7, 		8, 		7, 			5, 		7,      5,     10];
m = size(nombres,1);
n = size(elegidas,1);
if (ini)
	fprintf("Introduzca valoracion:\n");	
	for i = 1:m
		puts(nombres(i,:));
		fprintf("\t");
		r_global(i) = input("Power: ");
	end
	for i = 1:n
		puts(elegidas(i,:));
		fprintf("\t");
		r_elegidas(i) = input("Power: ");
	end
end
rand_v = randperm(m);%generates a random vector permutation for random names order
names="";
r=0;
fprintf("VALORES ACTUALES\n\n");
for i = 1:m
	names(i,:)=nombres(rand_v(i),:);
	r(i)=r_global(rand_v(i));
	puts(names(i,:));
	fprintf("\t%d", r(i));
	fprintf("\n");
end
for i = 1:n
	puts(elegidas(i,:));
	fprintf("\t\t%d", r_elegidas(i));
	fprintf("\n");
end

tach = names; %non used teams
med = sum(r)/length(r);
matrix = zeros(size(nombres,1));
if (pos) fprintf("\nPOSIBLES PAREJAS:\n"); end
for i = 1:m
	if(pos)
		fprintf("\nParejas de ");
		fprintf(names(i,:));
		fprintf("\n")
	end
	for j = 1:m
		aux = (r(i)+r(j))/2;
		if (i==j)
			continue;
		end
		if (aux<=med+e && aux>=med-e)
			matrix(i,j)=1;
			if(pos)
				fprintf(names(j,:));
				fprintf("\tPower=%d\n",aux);
			end		
			if (strcmp(tach(i,:), names(i,:))||strcmp(tach(i,:),names(i,:)))
				tach(i,:)=0;
			end			
		end
	end
end
matrix_ideal = matrix;
fprintf("\n--------------------------------------------------------------------\n");
fprintf("\n\t\tPAREJAS ELEGIDAS\n");%\e[1;34mThis is a blue text.\e[0m
fprintf("\nELEGIDAS AL AZAR\n");%\e[1;34mThis is a blue text.\e[0m
for i=1:m
	for j=1:m
		if(matrix_ideal(i,j)==matrix_ideal(j,i) && matrix_ideal(i,j)~=0)
			if(names(i,:)~=0 && names(j,:)~=0)
				aux = (r(i)+r(j))/2;
				fprintf(names(i,:));
				fprintf("\tcon\t");
				fprintf(names(j,:));
				fprintf("\tPower=%d\n",aux);
				%matrix_ideal(i,j)=0;
				%matrix_ideal(j,i)=0;
				names(i,:)=0;
				names(j,:)=0;
				i=1;
				j=1;
			end			
		end
	end
end
fprintf("\nELEGIDAS PREVIAMENTE\n");%\e[1;34mThis is a blue text.\e[0m
for i=1:(n-1)
	if (mod(i,2)==0)
		continue;
	end
	j=i+1;
	aux = (r_elegidas(i)+r_elegidas(j))/2;
	fprintf(elegidas(i,:));
	fprintf("\t\tcon\t");
	fprintf(elegidas(j,:));
	fprintf("\t\tPower=%d\n",aux);
end
fprintf("\n--------------------------------------------------------------------\n");


extra = "";
r_extra = 0;
c=1;
if (sum(sum(names)) == 0)
	return;
end
%fprintf("\n\nJugador no emparejados");
for i=1:m
	if(names(i,:)~=0)
		%fprintf("\n");
		%puts(names(i,:));
		aux = names(i,:);
		extra = [extra; aux];
		%fprintf("\t%d", r(i));
		r_extra(c)=r(i);
		c=c+1;
	end
end
if (size(extra,1)<2)
	fprintf("\n\n");
	return;
end
matrix_extra = zeros(size(extra,1));
fprintf("\n\nParejas jodidas de emparejar\n");
med_extra = sum(r_extra)/length(r_extra);
for i=1:length(r_extra)
	for j=1:length(r_extra)
		if(i==j)
			continue;
		end
		aux = (r_extra(i)+r_extra(j))/2;
		matrix_extra(i,j)=1;
	end
end

for i=1:length(r_extra)
	for j=1:length(r_extra)
		if(matrix_extra(i,j)==matrix_extra(j,i) && matrix_extra(i,j)~=0)
			if(extra(i,:)~=0 && extra(j,:)~=0)
				aux = (r_extra(i)+r_extra(j))/2;
				fprintf(extra(i,:));
				fprintf("\tcon\t");
				fprintf(extra(j,:));
				fprintf("\tPower=%d\n",aux);
				%matrix_nueva(i,j)=0;
				%matrix_nueva(j,i)=0;
				extra(i,:)=0;
				extra(j,:)=0;
				i=1;
				j=1;
			end			
		end
	end
end
fprintf("\n");