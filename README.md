# Tutorial - HttpLocalInfoServer e Forwarding
### Definições do trabalho:

Os alunos podem realizar esta atividade em duplas ou individualmente. 
Como entrega, será solicitado um tutorial de implementação descrevendo todos os passos necessários para a implementação do trabalho, de forma que outras pessoas possam reproduzi-lo (assim como é feito com os tutoriais de aula). 
Além disso, todo o desenvolvimento deve ser adicionado ao repositório de fontes e passar a fazer parte da distribuição.

[Definições do trabalho](./httpServer/tp1.pdf)

## PROJETO
Para execução do projeto, assumimos que você já tenha concluído algumas etapas anteriores que exigem:

* Habilitado um Driver de Ethernet
* Configurado o script de inicialização da interface de rede -> [Pasta de script](./custom-scripts/) 


## Etapas adicionais no nosso projeto
Incluímos no nosso projeto algumas configurações em ```make menuconfig```:
- passos para habilir a libc
- passos para habilitar o wchar
- passos para habiltiar o python

Criamos uma pasta no repositório par  guardar os arquivos desenvolvidos para o HTTP Server em python.

````mkdir httpServer````

E criamos um arquivo dentro da parta um arquivo [httpServer.py](./httpServer/httpServer.py). O arcabouço do código foi utilizado a partir do disponibilizado em aula

Utilizamos o código auxiliar [cpustat.py](./httpServer/cpustat.py) e o importamos no código. Principais importações

```
import time
from http.server import BaseHTTPRequestHandler,HTTPServer
import os
import cpustat as cpustat
```
A principal biblioteca os possui um metodo muito util, o **os.popen** que permite executar comandos no shell e obter seu output. Por exemplo:
```os.popen('date').read()``` retorna a hora no servidor com o comando ```date``` no shell.
A partir disso, utilizamos vários comandos nativos shell  para pre-processamento de dados como:
- cat
- grep
- awk
- | (pipe)

A partir disso, salvamos os vários comandos em variaveis e montamos o HTML. 

_**A cada novo request, os metodos são chamados e atulizados em tempo real os dados do servidor**_

## Forwading
<br/>
<br/>
<br/>
<br/>

## EXECUÇÃO:

A inicialização pode ser feita com o seguinte comando.


# Buildroot original readme
Buildroot is a simple, efficient and easy-to-use tool to generate embedded
Linux systems through cross-compilation.

The documentation can be found in docs/manual. You can generate a text
document with 'make manual-text' and read output/docs/manual/manual.text.
Online documentation can be found at http://buildroot.org/docs.html

To build and use the buildroot stuff, do the following:

1) run 'make menuconfig'
2) select the target architecture and the packages you wish to compile
3) run 'make'
4) wait while it compiles
5) find the kernel, bootloader, root filesystem, etc. in output/images

You do not need to be root to build or run buildroot.  Have fun!

Buildroot comes with a basic configuration for a number of boards. Run
'make list-defconfigs' to view the list of provided configurations.

Please feed suggestions, bug reports, insults, and bribes back to the
buildroot mailing list: buildroot@buildroot.org
You can also find us on # buildroot on OFTC IRC.

If you would like to contribute patches, please read
https://buildroot.org/manual.html# submitting-patches
