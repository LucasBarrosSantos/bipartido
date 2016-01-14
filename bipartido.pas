Program AlgoritmoemGrafos;
uses crt, dos;

var
MAdjacencia : Array [1..100,1..100] of integer; {Matriz de Adjacencia do Grafo}
n,m         : Integer;      {Quantidade de Vertices e de Arestas direcionadas do Grafo}
arquivo     : Text;         {Arquivo texto onde esta o Grafo}
arqok       : Boolean;      {Arquivo encontrado ou nao}
nomearquivo : String;       {Nome do arquivo a ser utilizado}
Auxarq      : Char;         {Auxiliar para colocar os dados do arquivo na matriz}
Snumero     : String;       {Numero do arquivo em formato String}
Inumero     : Integer;      {Numero do arquivo em formato inteiro}
I, J        : Integer;      {Auxiliares para varrer a matriz}
erro        : Integer;      {Erro na transformacao de String para Inteiro}

G1 : Array[1..100] of integer;  {Grupo 1 de vertices inteiros}
G2 : Array[1..100] of integer;  {Grupo 2 de vertices inteiros}
aux, aux1 : integer;

label 12;

function testeG1 (x:integer): boolean;
var c: integer;
begin

c := 1;
testeG1 := false;
while (G1[c] <> -1) do
  begin
     if (madjacencia [x,G1[c]] = 1) then
       begin
        testeG1 := true;
       end;
       c := c + 1;
  end;
end;

function testeG2 (x:integer): boolean;
  var c: integer;
   begin

    c := 1;
    testeG2 := false;
     while (G2[c] <> -1) do
        begin
          if (madjacencia [x,G2[c]] = 1) then
           begin
            testeG2 := true;
           end;
           c := c + 1;
        end;
   end;

{Função de busca do Grupo 1, recebe como parametro o vértice}
{Encontrar os verteces do Grupo 1}

FUNCTION buscaG1(v : integer):boolean;
     var c : integer;
begin
     c := 1;
     buscaG1 := false;
     while(G1[c] <> -1) do
     begin
         if(G1[c] = v)then
         begin
                  buscaG1 := true;
                 // break; // Se achou no Grupo 1, então sai do While();
         end;
         c := c + 1;
     end;
end;

{Função de busca do Grupo 2, recebe como parametro o vértice}
{Encontrar os verteces do grupo 2}
FUNCTION buscaG2(v : integer):boolean;
     var c : integer;
begin
     c := 1;
     buscaG2 := false;
     while(G2[c] <> -1) do
      begin
         if(G2[c] = v)then
         begin
                  buscaG2 := true;
                  //break; // Se achou no G2, etão sai do While();
         end;
         c := c + 1;
      end;
end;

{Função de inserir no Grupo 1, recebe como parametro o vértice}
FUNCTION inserirG1(v : integer):boolean;
     var c : integer;
Begin
     c := 1;
     while(c <= n) do
      begin
         if (not(buscaG1(v)) and not(buscaG2(v)) and (G1[c] = -1) and (not testeg1(v)))then
           begin
                G1[c] := v; // Se não achar em nenhum incere em G1[indice];
           end;
           c := c + 1;
      end;
end;

{Função de inserir no Grupo 2, recebe como parametro o vértice}
FUNCTION inserirG2(v : integer):boolean;
     var c : integer;
Begin
     c := 1;
     while(c <= n) do
       begin
         if ( not (buscaG1(v)) and not (buscag2(v)) and (G2[c] = -1) and (not TesteG2(v)))then
          begin
            G2[c] := v;
          end;
          c := c + 1;
       end;
end;

Begin
12:
for i := 1 to 100 do
begin
     G1[i] := -1;
     g2[i] := -1;
end;
aux := 0;
aux1 := 1;


     textbackground(3); // Mudar a cor de fundo do Dos
     textbackground(8);
     clrscr;
     arqok := false;
     while not arqok do         {Verificando a existencia do arquivo}
     begin
          textcolor(white);
          write('Digite o nome do arquivo: ');
          readln (nomearquivo);
          nomearquivo := concat(nomearquivo,'.txt');
          if Fsearch (nomearquivo,'') <> '' then {Procurar arquivo no caminho de pesquisa.}
          begin
               arqok := true;   {Existencia ou não de arquivo nesse caso sim}
               writeln('Arquivo localizado com sucesso!');
               readkey;
               clrscr;
          end
          else
          begin
               writeln ('Arquivo inexistente, tente novamente!')
          end;
     end;

     for i := 1 to 100 do
     for j := 1 to 100 do
     MAdjacencia [i,j] := 0;

     writeln('Trabalho do aluno: Lucas Barros');
     writeln(' ');
     writeln('Matriz de Adjacencia do Grafo no arquivo:');
     writeln(' ');

     assign (arquivo, nomearquivo); {Associa o arquivo texto onde tá o grafo com o nome do arquivo}
     reset (arquivo);         {Reinicia e abre  um arquivo existente para leitura}

     snumero := '';
     i := 1;    {Preenchimento inicial na linha  1 }
     j := 1;    {Preenchimento inicial na coluna 1 }
     m := 0;

     While not eof (arquivo) do         {Preenchimento da Matriz de Adjacencia do Grafo eof -> testa se e fim do arquivo}
     begin

          read(arquivo, auxarq);

          if (auxarq <> ' ') and (auxarq <> chr(13)) and (auxarq <> chr(10)) then {chr -> converte o valor byte  de valor de caracter}
          begin
               snumero := concat (snumero,auxarq); {Anexar uma corda para outra}
          end
          else
          begin
               val (snumero,inumero,erro); {Val converte o valor representado na string S para um valor numérico ou
                                                     um valor enumerado}

               if (erro <> 0) and (auxarq <> chr(10)) then
               begin
                    Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
                    readkey;
                    halt;
               end;

               snumero := '';
               MAdjacencia [i,j] := inumero;


               if (inumero <> 0) then
                  m := m + 1; {Definindo a quantidade de Arestas Dirigidas em digrafos}

               if auxarq = ' ' then
               begin
                    write (MAdjacencia [i,j], ' ');
                    j := j + 1;
               end
               else
               begin
                    if (auxarq <> chr(10)) then
                    begin
                         writeln (MAdjacencia [i,j], ' ');
                         i := i + 1;
                         j := 1;
                    end;
               end;
          end;          {do if}
     end;               {do while eof}

     val (snumero,inumero,erro);    {Val converte o valor representado na string S para um valor numérico ou
                                                     um valor enumerado}

          if (erro <> 0) and (auxarq <> chr(10))then
               begin
                    Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
                    readkey;
                    halt;
               end;

     MAdjacencia [i,j] := inumero;

     writeln (MAdjacencia [i,j], ' ');
     m := m div 2; {descomente essa linha para grafos}
     n := i;
     writeln('');
     writeln('');
     writeln(' N = ',n, ' M = ',m);
     Writeln;
     close(arquivo); {Fechar o arquivo}
     readkey;
     textcolor(Red);
     writeln('-----------------------------');
     writeln;
     {Inicializamos nossos grupos com -1, ou seja, não estão em nenhum grupo}
     for i:= 1 to n do
     begin
         G1[i] := -1; // Assim não estará em nenhum dos Grupos
         G2[i] := -1; // Assim não estará em nenhum dos Grupos
     end;


     {Inicializamos nosso G1 com o vértice 0}
     G1[1] := 0;
     for i:= 1 to n do
       begin
         for j:= 1 to n do
         begin
             if(MAdjacencia [i,j] = 1) then   {testamos se há ligações no vértice i}
             begin
                 if((buscaG1(i) = true) and (buscaG2(i) = false))then {testamos se já existe o vértice no grupo 1, e inserimos no grupo 2}
                               inserirG2(j)
                 else
                 if (buscaG1(i) = false) and (buscaG2(i) = true) then {testamos se já existe o vértice no grupo 2, e inserimos no grupo 1}
                               inserirG1(j)
                 else
                 if (buscaG1(i) = false) and (buscaG2(i) = false) then {testamos se é desconexo, e inserimos no grupo 2}
                               inserirG2(j)
                 else
                 if not(buscaG1(i)) and not(buscaG2(i)) then
                               inserirG1(j);
             end; // FimSe
         end; // FimFor
       end; // FimFor

     {Testando se é ou não bipartido}

   aux1 := 1;
   While (aux1 <= n) do
     Begin
       if (TesteG1(aux1) and (TesteG2(aux1))) then // Testa se existe toques de um vertice nele mesmo ou
        begin                                      // em algum outro vertice do mesmo Grupo!

            aux := 1; // Se os dois testes forem Verdade, então o Grafo não é Bipartido! Pois à toque em algum dos vertices no mesmo Grupo

        end;
       aux1 := aux1 + 1;
     end;

     {Testando se o retorno da busca é verdadeiro para existencia de vertices iguais nos dois grupos}
     if (aux = 1) then
         if(N = 2) and (M = 1) then  // Codição para o grafo K2 que é Bipartido Completo
          begin
              G1[1] := 1;
              G2[1] := 2;
              writeln('O grafo eh bipartido: ');
              TextColor(Blue);
              writeln;
              Write('    G1[ ',G1[1],' ]');
              writeln;
              Writeln;
              TextColor(Green);
              Write('    G2[ ',G2[1],' ]');
              Writeln;
          end else
             writeln('           Nao!           ')
     else
     begin
             writeln('O grafo eh bipartido: ');
             writeln;
             {imprimindo grupo 1}
             textcolor(blue);
      if (m = 0) and (n = 1) then {testar se e trivial}
        begin
              {inserirG1(1);}
              G1[1] := 1;
        end;
             writeln('    ');
             write('    G1[');
             for i:= 1 to n do
             begin
                   if(G1[i] <> -1) and (G1[i] <> 0) then
                   begin
                        write(' ');
                        write(G1[i]);
                        write(' ');
                   end;
             end;
             writeln(']');

             {imprimindo grupo 2}
             textcolor(green);
             writeln('    ');
             write('    G2[');
             for i:= 1 to n do
             begin
                   if(G2[i] <> -1) and (G2[i] <> 0) then
                   begin
                        write(' ');
                        write(G2[i]);
                        write(' ');
                   end;
             end;
             writeln(']');
     end;
     writeln;
     textcolor(red);
     writeln('-----------------------------');
     readkey;
     goto 12;
end.
