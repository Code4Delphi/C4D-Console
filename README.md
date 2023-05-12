#  C4D-Console - Framework para escrita de logs em Console Application
<p align="center">
  <a href="https://github.com/Code4Delphi/Code4D-Wizard/blob/master/Img/C4D-Logo.png">
    <img alt="Horse" height="100" src="https://github.com/Code4Delphi/Code4D-Wizard/blob/master/Img/c4d-logo-100x100.png">
  </a>  
</p>
Com o C4D-Console, você pode controlar de uma forma rápida e fácil, a escrita de Logs para quando estiver utilizando um projeto Console Application no Delphi



## 📞 Contacts

<p align="left">
  <a href="https://t.me/Code4DelphiDevs" target="_blank">
    <img src="https://img.shields.io/badge/Telegram:-Join%20Channel-blue?logo=telegram">
  </a> 
  &nbsp;
  <a href="mailto:contato@code4delphi.com.br" target="_blank">
    <img src="https://img.shields.io/badge/E--mail-contato%40code4delphi.com.br-yellowgreen?logo=maildotru&logoColor=yellowgreen">
  </a>
   &nbsp;
  <a href="https://go.hotmart.com/U81331747Y?dp=1" target="_blank">
    <img src="https://img.shields.io/badge/Course:-Open%20Tools%20API-F00?logo=delphi">
  </a> 
   &nbsp;
  <a href="https://www.youtube.com/@code4delphi" target="_blank">
    <img src="https://img.shields.io/badge/YouTube:-Join%20Channel-red?logo=youtube&logoColor=red">
  </a> 
</p>



## ⚙️ Instalação

* Instalação usando o [**Boss**](https://github.com/HashLoad/boss):

```
boss install github.com/Code4Delphi/C4D-Console
```

* **Instalação manual**: Abra seu Delphi e adicione a seguinte pasta ao seu projeto, em *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*

```
..\C4D-Console\Src
```



## 🚀 Como usar
* Adicione a uses a seu sistema:
```
uses
  C4D.Console;
```

* Configure os dados básicos do framework, caso deseje:
```
C4DConsole
     .Prefix('C4DConsoleDemo01')
     .Version('1.0.0')
     .Port(0);
```

* Estrutura básica de código, do arquivo .dpr:
```
uses
  C4D.Console;

var
 FDig: String;

begin
   ReportMemoryLeaksOnShutdown := True;
   C4DConsole
     .Prefix('MeuPrefix')
     .Version('1.0.0')
     .Port(0)
     .WriteInitialSummary('#CODE4DELPHI SERVIDOR INICIADO');

   FDig := '';
   while(FDig <> C4DConsole.CommandFinish)do
   begin
      ReadLn(FDig);
      C4DConsole.ProcessDigitated(FDig);
   end;
end.
```


## 👨‍💻 Comandos aceitos
* **-h** help
```
********************************************************************************
MeuPrefix AJUDA:
 -l   Desativar geração de log
 +l   Ativar geração de log
 -r   Gerar resumo
 \q   Encerrar
********************************************************************************
```

* **-l** Desativar a geração de log
```
********************************************************************************
LOG DESATIVADO
********************************************************************************
```

* **+l** Ativar a geração de log
```
********************************************************************************
LOG ATIVADO
********************************************************************************
```

* **-r** Exibe um resumo
```
********************************************************************************
MeuPrefix  RESUMO:
  Servidor iniciado em: 12/05/2023 00:38:49
  Servidor rodando a: 0 dias, 0 horas, 1 minutos e 40 segundos
  Porta: 0
  Versão: 1.0.0
  Caminho: C:\Componentes-Delphi\Code4D\C4D-Console\Samples\Demo01\Win32\Debug\C4DConsoleDemo01.exe
  Compilado em: 12/05/2023 00:38:17
********************************************************************************
```

## 🖥️ Métodos disponíveis:
* Verificar se o log esta ativo:
```
var
 LLogAtivo: Boolean;
begin
   LLogAtivo := C4DConsole.LogEnabled;
end;
```

* Ativa geração de Log:
```
C4DConsole.EnableLog;
```

* Desativar geração de Log:
```
C4DConsole.DisableLog;
```

### Outros métodos:

| Método | Tipo | Obter | Setar | Valor Default |
| ------------- | --------- | --------------------------------- | --------------------------------- | -------------- |
| Prefixo       | String    | ``` LPrefix := C4DConsole.Prefix; ```     | ``` C4DConsole.Prefix('MeuPrefix'); ```   | C4D            |
| Version       | String    | ``` LVersion := C4DConsole.Version; ```   | ``` C4DConsole.Version('0.0.0'); ```      | Vazio          |
| Port          | Integer   | ``` LPort := C4DConsole.Port; ```         | ``` C4DConsole.Port(9000); ```            | 0              |
| DhIni         | TDateTime | ``` LDhIni := C4DConsole.DhIni; ```       | ``` C4DConsole.DhIni(Now); ```            | Now            |
| CommandFinish | String    | ``` LStr := C4DConsole.CommandFinish; ``` | ``` C4DConsole.CommandFinish('\q'); ```   | \q             | 








