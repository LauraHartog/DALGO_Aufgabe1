## README##
####Autoren:  
Wichert, Franz; Matr. 6003113; E-Mail: franz.wichert@student.jade-hs.de   
Hartog, Laura; Matr. 6005625; E-Mail: laura.hartog@student.jade-hs.de

###Motivation:
Im Rahmen der Vorlesung *Daten und Algorithmen* des Studiengangs *Hörtechnik und Audiologie* wurde als Prüfungsleistung ein Programm geschrieben, das die Anforderung, einer graphischen Darstellung der aktuelle 5 Tage Wettervorhersage für die Stadt Oldenburg, die drei Komponeten umfasst, mindestens erfüllen soll. Die Umsetzung der Aufgabe erfolgt dabei in der Programmiersprache *Matlab*.


###Programmanleitung zum Skript 'weather\_forecast\_main\_script'
Zum Starten des Programms muss das Skript *weather\_forecast\_main\_script* geöffnet und ausgeführt werden. Es öffnet sich die Benutzeroberfläche *Weather Forecast Oldenburg*. Der Benutzer hat nun die Möglichkeit verschiedene Buttons zu verwenden, um die gewünschten Wetterdaten anzuzeigen:

* **startdate**: Durch einen linken Mausklick auf das Datum kann der Starttermin, der innerhalb der nächten 7 Tage liegt, ausgewählt werden.  
* **enddate**: Durch einen linken Mausklick kann das Enddatum geändert, also die anzuzeigene Zeitspanne, ausgewählt werden. Die Zeitspanne kann dabei zwischen 1 und 7 Tagen betragen. Das Enddatum sollte dabei ein Datum nach dem ausgewählten Startdatum sein.
* **update weatherdata**: Eine aktuelle Wettervorhersage der voreingestellten oder bereits veränderten Zeitspanne erscheint nach Links-Klick auf diesen Button. 

Die Zeitspanne der Wettervorhersage kann beliebig oft geändert werden. Durch erneutes Nutzen des *update weatherdata*-Buttons werden die Wetterdaten erneut aktualiesiert und dem eingestellten Zeitraum angepasst.

###Funktionsweise des Programms
In dem Skript  '**weather\_forecast\_main\_script**' werden die aktuellen Wetterdaten heruntergeladen, verarbeitet und geplottet. Dieses geschieht mithilfe der im Folgenden verwendeten Funktionen:   
* **parse\_xml**: Wandelt den [URL der Wetterdaten](http://api.met.no/weatherapi/locationforecast/1.8/?lat=53.143889;lon=8.213889 "Zum Öffnen Links-Klick") in zur Verarbeitung geeignete Structs um .(Copyright 2014 Bastian Bechtold)   
* **weather\_data\_reprocessing**: Die Daten des Wetter-URL werden im xml-Format gedownloadet und eingelesen. Aus den durch die Funktion *parse\-xml* erstellten Structs werden die zu verarbeiteten Wetterdaten ausgelesen und in einem alle nötigen Informatonen enthaltenen Struct an das Hauptskript übergeben.    
* **error\_window\_fct**: Aufruf durch Einstellen von End- und Startdatum. Es wird überprüft, ob das ausgewählte Enddatum vor dem ausgewählten Startdatum liegt. Ist dieses der Fall, wird eine Fehlermeldung geöffnet und der *update weatherdata*-Button deaktiviert.   
* **update\_weather\_fct**: Aufruf durch Klick auf *update weatherdata*-Button. Für die ausgewälte Zeitspanne werden für jeden Tag die Wetterinformationen für morgens, mittags, abends dargestellt (Verwendete Bilder: [www.wetter.com](http://www.wetter.com/ "Öffnen") ) Der *update weatherdata*-Button wird beim plotten der Daten deaktiviert.

###Getestete Plattformen:

* Windows 7 Home Premium; MATLAB R2013a Student Version (32-bit)  
* 
 

