import time
from http.server import BaseHTTPRequestHandler,HTTPServer
import os
import cpustat as cpustat


HOST_NAME = '127.0.0.1' # !!!REMEMBER TO CHANGE THIS!!!
PORT_NUMBER = 8000


class MyHandler(BaseHTTPRequestHandler):
    def do_HEAD(s):
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()
    def do_GET(s):
        """Respond to a GET request."""
        
        datahora = os.popen('date').read()
        systime = os.popen("awk '{print $1}' /proc/uptime").read()
        cpuModel = os.popen("lscpu | grep 'Model name'").read()
        cpuCores = os.popen("lscpu | grep 'CPU(s):' | head -n1").read()
        memRamUsada = os.popen("free -m | grep 'Mem' | awk '{print $2}'").read()
        memRamTotal =  os.popen("free -m | grep 'Mem' | awk '{print $3}'").read()
        sysVersion = os.popen("cat /etc/*release* | grep 'DISTRIB_DESCRIPTION'| awk -F '=' '{print $2}'").read()
        listProc = os.popen("ps aux | awk '{print $1 \" = \" $2 \" = \" $11 \"<br>\"}'").read()

        cpu = cpustat.GetCpuLoad()

        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()
        s.wfile.write("<html><head><title>T1 Laboratorio de Sistema Operacional.</title></head>".encode())
        s.wfile.write("<body>".encode())
        s.wfile.write("<h1>T1 Laboratorio de Sistema Operacional.</h1>".encode())
        # If someone went to "http://something.somewhere.net/foo/bar/",
        # then s.path equals "/foo/bar/".

        
        s.wfile.write(("<h2>Data e hora do sistema: </h2>").encode())
        s.wfile.write(("<p> - "+str(datahora)+"</p>").encode())

        s.wfile.write(("<h2>Uptime (tempo de funcionamento sem reinicializacao do sistema) em segundos: </h2>").encode())
        s.wfile.write(("<p> - "+str(systime)+"</p>").encode())

        s.wfile.write(("<h2>Modelo do processador e velocidade : </h2>").encode())
        s.wfile.write(("<p> - "+str(cpuModel)+"</p>").encode())
        s.wfile.write(("<p> - "+str(cpuCores)+"</p>").encode())

        s.wfile.write(("<h2>Capacidade ocupada do processador (%): </h2>").encode())
        s.wfile.write(("<p> - "+str(cpu.getcpuload())+"</p>").encode())

        s.wfile.write(("<h2>Quantidade de memoria RAM total e usada (MB): </h2>").encode())
        s.wfile.write(("<p> - Total MB "+str(memRamTotal)+"</p>").encode())
        s.wfile.write(("<p> - Usado MB "+str(memRamUsada)+"</p>").encode())

        s.wfile.write(("<h2>Versao do sistema:</h2>").encode())
        s.wfile.write(("<p> - "+str(sysVersion)+"</p>").encode())

        s.wfile.write(("<h2>Lista de processos em execucao (pid e nome)</h2>").encode())
        s.wfile.write(("<p>"+str(listProc)+"</p>").encode())


        s.wfile.write("</body></html>".encode())

if __name__ == '__main__':
    httpd = HTTPServer((HOST_NAME, PORT_NUMBER), MyHandler)
    print("Server Starts - %s:%s" % (HOST_NAME, PORT_NUMBER))
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    print("Server Stops - %s:%s" % (HOST_NAME, PORT_NUMBER))
