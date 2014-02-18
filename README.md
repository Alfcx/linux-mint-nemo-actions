linux-mint-nemo-actions
=======================
## 1. Overwiew ##
This Repository contains bilingual (english and german) Nemo Actions for Linux Mint. The Shell/Zenity Scripts should also work on other debian based Distros.

## 2. About Nemo Actions in general ##
Nemo Actions (Linux Mint) or Nautilus Actions (Ubuntu) lets you run a command, a script or a program from the context menu (the menu that shows up when you right-click on a file or folder).<br>
Linux Mint stores the Nemo Actions in <code>~/.local/share/nemo/actions</code> (user) and <code>/usr/share/nemo/actions</code> (system-wide).

## 3. The Nemo Actions in this Repository ##
This repository contains nemo actions focused on (pdf) document management, and the post processing of scanned documents.<br>

### 3.1 Convert doc(x) to odt ###
#### 3.1.1 Files ####
* convert-doc-to-odt.nemo_action

#### 3.1.2 Description ####
Converts Microsoft Office Documents (doc and docx) to Documents in the LibreOffice Format (odt).

#### 3.1.3 Prerequisites ###
Unoconv is used to convert the files.
<pre><code>
sudo apt-get update
sudo apt-get install unoconv
</code></pre>
### 3.2 Convert doc(x)/odt/txt to pdf ###
#### 3.2.1 Files ####
* convert-to-pdf.nemo_action

#### 3.2.2 Description ####
Converts doc, docx, odt and txt files to pdf.

#### 3.2.3 Prerequisites ####
Unoconv is used to convert the files.
<pre><code>
sudo apt-get update
sudo apt-get install unoconv
</code></pre>
### 3.3 Downsize pdf files ###
#### 3.3.1 Files ####
* pdf-downsize.nemo_action
* pdf-downsize.sh
* pdf-downsize-de.sh
* pdf-downsize-en.sh

#### 3.3.2 Description ####
Makes your scanned pdf files smaller and stores the original file in the archive directory.

#### 3.3.3 Prerequisites ####
Ghostscript is used to work the pdf file. Zenity is used to for the GUI. 
<pre><code>
sudo apt-get update
sudo apt-get install ghostscript zenity
</code></pre>
### 3.4 Edit pdf metadata ###
#### 3.4.1 Files ####
* pdf-metadata-edit.nemo_action
* pdf-metadata-edit.sh
* pdf-metadata-edit-de.sh
* pdf-metadata-edit-en.sh

#### 3.4.2 Description ####
Lets you edit the <b>author</b>- and the <b>title</b>-tag of a pdf file.

#### 3.4.3 Prerequisites ####
Pdftk is used to work the pdf file. Zenity is used to for the GUI.
<pre><code>
sudo apt-get update
sudo apt-get install pdftk zenity
</code></pre>
### 3.5 Rotate the pages of a pdf file ###
#### 3.5.1 Files ####
* pdf-rotate.nemo_action
* pdf-rotate.sh
* pdf-rotate-de.sh
* pdf-rotate-en.sh

#### 3.5.2 Description ####
Lets you rotate the pages of a pdf file (90° cw, 90° ccw, 180°). Ideal for scanned documents.

#### 3.5.3 Prerequisites ####
Pdftk is used to rotate the pages. Zenity is used to for the GUI.
<pre><code>
sudo apt-get update
sudo apt-get install pdftk zenity
</code></pre>

### 3.6 Create a sandwich-pdf file ###
#### 3.6.1 Files ####
* scan-to-sandwich-pdf.nemo_action
* scan-to-sandwich-pdf.sh
* scan-to-sandwich-pdf-de.sh
* scan-to-sandwich-pdf-en.sh

#### 3.6.2 Description ####
Takes your scanned documents (pdf or tif), splits double pages (if necessary), corrects page alignement, sets document to black and white, runs text recognition and adds the text layer to the pdf file. You end up with a searchable/indexable pdf file, a so called sandwich-pdf file.<br>
If necessary apply the rotate script (3.5) first, otherwise the text recognition will fail.

#### 3.6.3 Prerequisites ####
This Script uses several programs. 
<pre><code>
sudo apt-get update
sudo apt-get install zenity ghostscript scantailor tesseract-ocr tesseract-ocr-deu tesseract-ocr-fra exactimage pdftk
</code></pre>

## 4. Install Nemo Actions from this Repository ##
1. Fire up a terminal; make a directory, where you can store the files from this repository; enter this directory:
<pre><code>
mkdir ~/Downloads/linux-mint-nemo-actions
cd ~/Downloads/linux-mint-nemo-actions
</code></pre>

2. Clone the files from this repository to your computer.
<pre><code>
git clone https://github.com/Alfcx/linux-mint-nemo-actions
</code></pre>

3. Make sure you have the necessary programs (for the nemo action you want) installed on your system. E.G. for the sandwich-pdf nemo action you'll have to run:
<pre><code>
sudo apt-get update
sudo apt-get install zenity ghostscript scantailor tesseract-ocr tesseract-ocr-deu tesseract-ocr-fra exactimage pdftk
</code></pre>

4. Copy the files for the wanted nemo action to your nemo actions directory and make sure the shell scripts are executable.  E.G. for the sandwich pdf nemo action you'll have to run:
<pre><code>
cp scan-to-sandwich-pdf.nemo_action ~/.local/share/nemo/actions
cp scan-to-sandwich-pdf.sh ~/.local/share/nemo/actions
cp scan-to-sandwich-pdf-de.sh ~/.local/share/nemo/actions
cp scan-to-sandwich-pdf-en.sh ~/.local/share/nemo/actions
chmod +x ~/.local/share/nemo/actions/scan-to-sandwich-pdf.sh
chomd +x ~/.local/share/nemo/actions/scan-to-sandwich-pdf-de.sh
chmod +x ~/.local/share/nemo/actions/scan-to-sandwich-pdf-en.sh
</code></pre>
5. Test if it works. E.G. for the sandwich pdf nemo action you can right-click on a pdf file and look for the entry "Create Sandwich-PDF". If it doesn't work reload cinnamon.
<pre><code>
cinnamon --replace
</code></pre>
6. Have Fun with your nemo actions and let me know if they work for you. 