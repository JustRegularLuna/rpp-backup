# Linux

	sudo apt-get install make gcc bison git python python-setuptools
	sudo easy_install pypng

	git clone git://github.com/bentley/rgbds.git
	cd rgbds
	sudo make install
	cd ..

	git clone --recursive git://github.com/TheFakeMateo/RedPlusPlus.git
	cd RedPlusPlus

To build **pokered.gbc** and **pokeblue.gbc**:

	make

To build them individually:

	make red
	make blue


# Mac

In the shell, run:

	xcode-select --install
	sudo easy_install pypng

	git clone git://github.com/bentley/rgbds.git
	cd rgbds
	sudo make install
	cd ..

	git clone --recursive git://github.com/TheFakeMateo/RedPlusPlus.git
	cd RedPlusPlus

	make



# Windows

To build on Windows, use [**Cygwin**](http://cygwin.com/install.html). Use the default settings.

Then get the most recent version of [**rgbds**](https://github.com/bentley/rgbds/releases/).
Extract the archive and put `rgbasm.exe`, `rgblink.exe` and `rgbfix.exe` in `C:\cygwin\usr\local\bin`.

In the **Cygwin terminal**:

	install $(lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg) /bin
	apt-cyg install make git python gettext

	lynx -source bootstrap.pypa.io/get-pip.py | python
	pip install pypng

	git clone --recursive https://github.com/TheFakeMateo/RedPlusPlus.git
	cd RedPlusPlus

	make
	
"pokered.gbc" will be the "Normal" version and "pokeblue.gbc" will be the "Hard" version.
