#include <cstdio>
 #include <iostream>
 using namespace std;
int main(int argc, char *argv[]){
	 int Opc;
std::cout << "\nPROYECTO FINAL - EZEQUIEL VEGA AGUERO" << std::endl;
std::cout << "1-Programa Piramide" << std::endl;
std::cout << "2-Menor Y Mayor" << std::endl;
std::cout << "3-Arreglo Ordenado " << std::endl;
std::cout << "4-MODA, MEDIANA Y MEDIA" << std::endl;
std::cout << "5-Salir\n" << std::endl;
std::cout << "Programa a probar: " << std::endl;
	 std::cin >> Opc;
while(Opc!=5){
if(Opc==1){
	 int valor;
std::cout << "Numero: " << std::endl;
	 std::cin >> valor;
	 int i;
for(int i=valor;i>=1;i=i-1){
	 int j;
for(int j=0;j<i;j=j+1){
std::cout << "*";}
std::cout << "" << std::endl;
}
}
else if(Opc==2){
	 int X,num,nummayor;
	 int nummenor;
X=1;
nummayor=0;
nummenor=0;
while(X<=5){
std::cout << "\nNumero" << std::endl;
	 std::cin >> num;
if(X==1){
nummayor=num;
nummenor=num;
}
else if(num>nummayor){
nummayor=num;
}
else if(num<nummenor){
nummenor=num;
}
X+=1;
}
std::cout << "\nEl mayor es: " << nummayor << std::endl;std::cout << "\nEl menor es: " << nummenor << std::endl;std::cout << "" << std::endl;
}
else if(Opc==3){
	 int menor;
	 int numero;
	 int temporal;
int Array[10];
std::cout << "Ingresa 10 Números\n" << std::endl;
for(int i=0;i<=9;i=i+1){
std::cout << "Número" << std::endl;
	 std::cin >> numero;
Array[i]=numero;
}
std::cout << " " << std::endl;
for(int j=0;j<=9;j=j+1){
	 int n;
n=j+1;
for(int t=0;t<=8;t=t+1){
if(Array[t]<Array[n]){
temporal=Array[n];
Array[n]=Array[t];
Array[t]=temporal;
}
}
}
std::cout << "Arreglo Ordenado" << std::endl;
for(int t=9;t>=0;t=t-1){
std::cout << Array[t]  << std::endl;
}
}
else if(Opc==4){
int Array[10];
int Aux[10];
	 int Cont;
	 int Posicion;
	 int Numero;
	 int Cont2;
	 int posMayor;
	 int Num;
	 int NumMayor;
	 int O;
O=0;
	 int Band;
	 int temporal;
Band=0;
	 int n;
	 int suma;
	 float media;
media=0;
suma=0;
Numero=0;
std::cout << "Dame 10 Números\n" << std::endl;
for(int i=0;i<10;i=i+1){
std::cout << "Dame Número:" << std::endl;
	 std::cin >> Num;
Array[i]=Num;
}
for(int Cont=0;Cont<=9;Cont=Cont+1){
Aux[Cont]=0;
}
for(int Cont=0;Cont<10;Cont=Cont+1){
Numero=Array[Cont];
Posicion=Cont;
for(int Cont2=Cont;Cont2<=9;Cont2=Cont2+1){
if(Array[Cont2]==Numero){
Aux[Posicion]+=1;
}
}
}
NumMayor=Aux[O];
posMayor=0;
for(int Cont=0;Cont<=9;Cont=Cont+1){
if(Aux[Cont]>NumMayor){
posMayor=Cont;
NumMayor=Aux[Cont];
}
}
std::cout << "\nMODA: " << std::endl;
std::cout << Array[posMayor]  << std::endl;
for(int j=0;j<=9;j=j+1){
	 int n;
n=j+1;
for(int t=0;t<=8;t=t+1){
if(Array[t]<Array[n]){
temporal=Array[n];
Array[n]=Array[t];
Array[t]=temporal;
}
}
}
std::cout << "Arreglo Ordenado" << std::endl;
for(int t=9;t>=0;t=t-1){
std::cout << Array[t]  << std::endl;
}
std::cout << "\nMEDIANA: " << std::endl;
std::cout << Array[5]  << std::endl;
std::cout << "y" << std::endl;
std::cout << Array[4]  << std::endl;
for(int Cont=0;Cont<=9;Cont=Cont+1){
suma+=Array[Cont];
}
media=(float)suma/10.0;
std::cout << "MEDIA: " << media << std::endl;}
else{
std::cout << "\nError\n" << std::endl;

}
std::cout << "\nPROYECTO FINAL - EZEQUIEL VEGA AGUERO" << std::endl;
std::cout << "1-Programa Piramide" << std::endl;
std::cout << "2-Menor Y Mayor" << std::endl;
std::cout << "3-Arreglo Ordenado" << std::endl;
std::cout << "4. MODA, MEDIANA Y MEDIA" << std::endl;
std::cout << "5. Salir\n" << std::endl;
std::cout << "Programa a probar: " << std::endl;
	 std::cin >> Opc;
}

}

