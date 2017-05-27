# Linux

	sudo apt-get install make gcc bison git python

	git clone https://github.com/bentley/rgbds
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

In **Terminal**, run:

	xcode-select --install

	git clone https://github.com/bentley/rgbds
	cd rgbds
	sudo make install
	cd ..

	git clone --recursive git://github.com/TheFakeMateo/RedPlusPlus.git
	cd RedPlusPlus

	make



# Windows

It is probably easiest to just follow [**This Video Tutorial**](https://www.youtube.com/watch?v=fYytG7IUUWg).
Just use this project's url instead of the vanilla Pokered url.


Original instructions are below:

To build on Windows, use [**Cygwin**](http://cygwin.com/install.html). Use the default settings.

In the installer, select the following packages: `make` `git` `python` `gettext`

Then get the most recent version of [**rgbds**](https://github.com/bentley/rgbds/releases/).
Extract the archive and put `rgbasm.exe`, `rgblink.exe` and `rgbfix.exe` in `C:\cygwin\usr\local\bin`.

In the **Cygwin terminal**:

	git clone --recursive https://github.com/TheFakeMateo/RedPlusPlus.git
	cd RedPlusPlus

	make
	
"pokered.gbc" will be the "Normal" version and "pokeblue.gbc" will be the "Hard" version.
