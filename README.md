# Painel digital para ventiladores de mesa

## Componentes

- Raphael Ramos
- Paulo Ricardo
- Emanoel Batista
- Lucas Felipe

## Ideia 

Este dispositivo trata-se de um painel digital para um ventilador de mesa com acionamento de três velocidades das hélices e habilitação de um modo de economia de energia

## Descrição de hardware

As seguintes entidades foram implementadas

- DigitalFan (*top level* entity) 
- ModeController é o controlador que habilita/desabilita o modo de economia de energia
- IntensityController é o controlador que alterna sequencialmente entre as três velocidades
- TimerLoadable é o temporizador utilizado para controlar o modo de economia de energia

## Simulações

As simulações descritas no relatório estão no formato de University Progam Waveform VWF. Elas podem ser encontradas na raiz deste repositóri

- WaveformIntensity.vwf contém as formas de ondas relativas a alternância das velocidades
- WaveformModes.vwf contém as formas de ondas relativas ao modo de economia de energia
