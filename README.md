Linux Mint Nemo Actions by Alfcx
================================
## 1. Abstract ##
![doc menu](screenshots/doc-menu.png)
![pdf menu](screenshots/pdf-menu.png)

Nemo Actions (Linux Mint) or Nautilus Actions (Ubuntu) let you run a command, a script or a program from the context menu (the menu that shows up when you right-click on a file or folder).<br>
This Repository contains Nemo Actions for Linux Mint focused on the postprocessing of scanned documents and document management. The Shell/Zenity Scripts should work on other debian based Distros too. At the moment the GUIs are available in english and german (other languages: ready to translate). The featured Nemo Actions are:

<b>1. PDF Document Page Rotator</b>
<br>Lets you rotate all the pages of a pdf document in one click ([more](#21-pdf-document-page-rotator)).
<br><br>
<b>2. Scan to Sandwich PDF</b>
<br>This script takes your scanned document (tif or pdf), removes the black borders, splits double pages, corrects the alignement, sets the document to black and white, runs <b>text recognition</b> and adds a text layer to the document. You will end up with a seachable/indexable pdf document. This script backs up the original file in an archive directory too ([more](#22-scan-to-sandwich-pdf)).
<br><br>
<b>3. PDF Metadata Editor</b>
<br>Lets you edit the title- and author-tag of a pdf file ([more](#23-pdf-metadata-editor)).
<br><br>
<b>4. Pdf Document Downsizer</b>
<br>Reduces the size of your scanned pdf documents and stores the original file in an archive directory ([more](#24-pdf-document-downsizer)).
<br><br>
<b>5. doc(x) to odt Converter</b>
<br>Converts Microsoft Office documents (doc, docx) to do documents in the LibreOffice (odt) format ([more](#25-docx-to-odt-converter)).
<br><br>
<b>6. doc(x), odt, txt to pdf Converter</b>
<br>Converts your doc, docx, odt and txt documents to pdf files ([more](#26-docx-odt-txt-to-pdf-converter)).
<br>

## 2. Detailed View on the Nemo Actions in this Repository ##
### 2.1 PDF Document Page Rotator ###
#### 2.1.1 Files ####
* pdf-rotator.nemo_action
* pdf-rotator/pdf-rotator.sh
* pdf-rotator/lang/de.ini
* pdf-rotator/lang/en.ini

#### 2.1.2 Description ####
Lets you rotate all the the pages of a pdf file in one click (90° cw, 90° ccw, 180°).
It's ideal for scanned multipage documents.<br>
![PDF Rotate](screenshots/pdf-rotate.png)<br>
In the background runs this one-liner:
<pre><code>pdftk "INPUT" cat "ROTATION" output "OUTPUT" ;</code></pre>

#### 2.1.3 Prerequisites ####
Pdftk is used to rotate the pages. Zenity is used to for the GUI.
<pre><code>sudo apt-get update
sudo apt-get install pdftk zenity</code></pre>

### 2.2 Scan to Sandwich PDF ###
#### 2.2.1 Files ####
* scan-to-sandwich-pdf.nemo_action
* scan-to-sandwich-pdf/scan-to-sandwich-pdf.sh
* scan-to-sandwich-pdf/config.ini
* scan-to-sandwich-pdf/lang/de.ini
* scan-to-sandwich-pdf/lang/en.ini

#### 2.2.2 Description ####
Takes your scanned documents (pdf or tif), removes the black border, splits double pages (if necessary), corrects page alignement, sets document to black and white, runs text recognition and adds the text layer to the pdf file. You will end up with a searchable/indexable pdf file, a so called sandwich-pdf file.<br>
If necessary apply the [PDF Document Page Rotator](#21-pdf-document-page-rotator) first, otherwise the text recognition will fail.<br>
<img src="screenshots/scan-to-sandwich-pdf-1.png" width="360">
<img src="screenshots/scan-to-sandwich-pdf-2.png" width="360">
<img src="screenshots/scan-to-sandwich-pdf-3.png" width="360">

#### 2.2.3 Prerequisites ####
This Script uses several programs. 
<pre><code>sudo apt-get update
sudo apt-get install zenity ghostscript scantailor tesseract-ocr tesseract-ocr-deu tesseract-ocr-fra exactimage pdftk</code></pre>


### 2.3 PDF Metadata Editor ###
#### 2.3.1 Files ####
* pdf-metadata-editor.nemo_action
* pdf-metadata-editor/pdf-metadata-editor.sh
* pdf-metadata-editor/lang/de.ini
* pdf-metadata-editor/lang/en.ini

#### 2.3.2 Description ####
Lets you edit the <b>author</b>- and the <b>title</b>-tag of a pdf file.<br>
![PDF Metadata Edit 1](screenshots/pdf-edit-metadata-1.png)
![PDF Metadata Edit 2](screenshots/pdf-edit-metadata-2.png)

#### 2.3.3 Prerequisites ####
Pdftk is used to work the pdf file. Zenity is used to for the GUI.
<pre><code>sudo apt-get update
sudo apt-get install pdftk zenity</code></pre>

### 2.4 PDF Document Downsizer ###
#### 2.4.1 Files ####
* pdf-downsizer.nemo_action
* pdf-downsizer/pdf-downsizer.sh
* pdf-downsizer/config.ini
* pdf-downsizer/lang/en.ini
* pdf-downsizer/lang/de.ini

#### 2.4.2 Description ####
Reduces the size of your scanned pdf files by running this ghostscript one-liner on the document:
<pre><code>gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="OUTPUTFILE" "INPUTFILE" ;</code></pre>
Also makes a backup of the original file in an archive directory (default: /home/$USER/Scan-Archive; will be created, if it doesn't exist).<br>
You don't need to run this script on files you edited with [Scan to Sandwich PDF](#22-scan-to-sandwich-pdf) (this script already downsizes the pdf files). 

#### 2.4.3 Prerequisites ####
Ghostscript is used to work the pdf file. Zenity is used to for the GUI. 
<pre><code>sudo apt-get update
sudo apt-get install ghostscript zenity</code></pre>

### 2.5 doc(x) to odt Converter ###
#### 2.5.1 Files ####
* convert-doc-to-odt.nemo_action

#### 2.5.2 Description ####
Converts Microsoft Office Documents (doc and docx) to Documents in the LibreOffice Format (odt) by
<pre><code>unoconv -f odt "YOURFILE"</code></pre>

#### 2.5.3 Prerequisites ###
Unoconv is used to convert the files.
<pre><code>sudo apt-get update
sudo apt-get install unoconv</code></pre>

### 2.6 doc(x), odt, txt to pdf Converter ###
#### 2.6.1 Files ####
* convert-to-pdf.nemo_action

#### 2.6.2 Description ####
Converts doc, docx, odt and txt files to pdf by
<pre><code>unoconv "YOURFILE"</code></pre>


#### 2.6.3 Prerequisites ####
Unoconv is used to convert the files.
<pre><code>sudo apt-get update
sudo apt-get install unoconv</code></pre>

### 2.7 PDF Merger ###
#### 2.7.1 Files ####
* pdf-merger.nemo_action
* pdf-merger/pdf-merger.sh
* pdf-merger/config.ini
* pdf-merger/lang/de.ini
* pdf-merger/lang/en.ini

#### 2.7.2 Description ####
Combines multiple marked pdf files in alphabetical order to one pdf file. In the background pdftk does the magic:
<pre><code>pdftk INPUT1 INPUT2 INPUT3 cat output "OUTPUT"</code></pre>
You can choose if the input files should be deleted after processing or not (in the config.ini).

#### 2.7.3. Prerequisites ####
Pdftk is used to build the file. Zenity is used for the GUI.
<pre><code>sudo apt-get update
sudo apt-get install pdftk zenity</code></pre>

## 3. Install Nemo Actions from this Repository ##
1. Fire up a terminal; make a directory, where you can store the files from this repository; enter this directory:
<pre><code>mkdir ~/Downloads/linux-mint-nemo-actions
cd ~/Downloads/linux-mint-nemo-actions</code></pre>

2. Clone the files from this repository to your computer.
<pre><code>git clone https://github.com/Alfcx/linux-mint-nemo-actions</code></pre>

3. Make sure you have the necessary programs (for the nemo action you want) installed on your system. E.g. for the sandwich-pdf nemo action you'll have to run:
<pre><code>sudo apt-get update
sudo apt-get install zenity ghostscript scantailor tesseract-ocr tesseract-ocr-deu tesseract-ocr-fra exactimage pdftk</code></pre>

4. Copy the files and folders for the wanted nemo action to your nemo actions directory. Linux Mint stores the Nemo Actions in <code>~/.local/share/nemo/actions</code> (user) and <code>/usr/share/nemo/actions</code> (system-wide).
Also make sure the shell script is executable.  E.g. for the "scan to sandwich pdf" nemo action you'll have to run:
<pre><code>cp scan-to-sandwich-pdf.nemo_action ~/.local/share/nemo/actions
mkdir ~/.local/share/nemo/actions/scan-to-sandwich-pdf
cp -r scan-to-sandwich-pdf/* ~/.local/share/nemo/actions/scan-to-sandwich-pdf
chmod +x ~/.local/share/nemo/actions/scan-to-sandwich-pdf/scan-to-sandwich-pdf.sh</code></pre>
5. You should now be able to see your Nemo Action in the context menu (e.g. you'll see "Create Sandwich-PDF" when you right-click on a pdf file). If you don't see the Nemo Action, log out and back in. Have Fun with this Nemo Actions and let me know if they work for you.