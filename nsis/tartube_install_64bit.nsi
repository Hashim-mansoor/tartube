# Tartube v2.5.113 installer script for MS Windows
#
# Copyright (C) 2019-2025 A S Lewis
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#
# Build instructions:
#   - These instructions describe how to create an installer for Tartube on a
#       64-bit MS Windows machine, Windows Vista or higher
#
#   - Download and install NSIS from
#
#       http://nsis.sourceforge.io/Download/
#
#   - Download the 64-bit version of MSYS2. The downloadable file should look
#       something like 'msys2-x86-64-yyyymmdd.exe'
#
#       http://www.msys2.org/
#
#   - Run the file to install MSYS2. We suggest that you create a top-level
#       folder. Here, we call it C:\testme. Let MSYS2 install itself inside
#       that directory, i.e. C:\testme\msys64
#
#   - Run the mingw64 terminal, i.e.
#
#       C:\testme\msys64\mingw64.exe
#
#   - We need to install various dependencies. In the terminal window, type
#       this command
#
#       pacman -Syu
#
#   - Usually, the terminal window tells you to close it. Do that, and then
#       open a new mingw64 terminal window
#
#   - In the new window, type these commands
#
#       pacman -Su
#       pacman -S mingw-w64-x86_64-python3
#       pacman -S mingw-w64-x86_64-python3-pip
#       pacman -S mingw-w64-x86_64-python3-gobject
#       pacman -S mingw-w64-x86_64-python3-requests
#       pacman -S mingw-w64-x86_64-gtk3
#       pacman -S mingw-w64-x86_64-gsettings-desktop-schemas
#
#   - Optional step: you can check that the dependencies are working by typing
#       this command (if you like):
#
#       gtk3-demo
#
#   - The C:\testme folder now contains about 2GB of data. If you like, you can
#       use all of it (which would create an installer of about 600MB). In most
#       cases, though, you will probably want to remove everything that's not
#       necessary
#
#   - This table shows which files and folders are in the official Tartube
#       installer (which is about 120MB). Files/folders ending in * represent
#       multiple files/folders which must be retained. Everything else can be
#       deleted
#
#   - Note that version numbers will change over time; retain which version of
#       the file/folder is available
#
#       C:\testme\msys64\clang64
#       C:\testme\msys64\clangarm64
#       C:\testme\msys64\dev
#       C:\testme\msys64\etc
#       C:\testme\msys64\home
#       C:\testme\msys64\installerResources
#       C:\testme\msys64\mingw64.exe
#       C:\testme\msys64\mingw64\bin
#       C:\testme\msys64\mingw64\bin\gdbus*
#       C:\testme\msys64\mingw64\bin\gdk*
#       C:\testme\msys64\mingw64\bin\gettext*
#       C:\testme\msys64\mingw64\bin\gio*
#       C:\testme\msys64\mingw64\bin\glib*
#       C:\testme\msys64\mingw64\bin\gobject*
#       C:\testme\msys64\mingw64\bin\gsettings
#       C:\testme\msys64\mingw64\bin\gtk*
#       C:\testme\msys64\mingw64\bin\img2webp
#       C:\testme\msys64\mingw64\bin\json*
#       C:\testme\msys64\mingw64\bin\lib*
#       C:\testme\msys64\mingw64\bin\msvcr*
#       C:\testme\msys64\mingw64\bin\openssl
#       C:\testme\msys64\mingw64\bin\pip*
#       C:\testme\msys64\mingw64\bin\python*
#       C:\testme\msys64\mingw64\bin\sqlite*
#       C:\testme\msys64\mingw64\bin\xml*
#       C:\testme\msys64\mingw64\bin\zlib1.dll
#       C:\testme\msys64\mingw64\include\gdk-pixbuf-2.0
#       C:\testme\msys64\mingw64\include\gio-win32-2.0
#       C:\testme\msys64\mingw64\include\glib-2.0
#       C:\testme\msys64\mingw64\include\gsettings-desktop-schemas
#       C:\testme\msys64\mingw64\include\gtk-3.0
#       C:\testme\msys64\mingw64\include\json-glib-1.0
#       C:\testme\msys64\mingw64\include\libxml2
#       C:\testme\msys64\mingw64\include\ncurses
#       C:\testme\msys64\mingw64\include\ncursesw
#       C:\testme\msys64\mingw64\include\openssl
#       C:\testme\msys64\mingw64\include\pycairo
#       C:\testme\msys64\mingw64\include\pygobject-3.0
#       C:\testme\msys64\mingw64\include\python3.9
#       C:\testme\msys64\mingw64\include\readline
#       C:\testme\msys64\mingw64\include\tk8.6
#       C:\testme\msys64\mingw64\lib\gdk-pixbuf-2.0
#       C:\testme\msys64\mingw64\lib\gettext
#       C:\testme\msys64\mingw64\lib\girepository-1.0
#       C:\testme\msys64\mingw64\lib\glib-2.0
#       C:\testme\msys64\mingw64\lib\gtk-3.0
#       C:\testme\msys64\mingw64\lib\python3.9\asyncio
#       C:\testme\msys64\mingw64\lib\python3.9\collections
#       C:\testme\msys64\mingw64\lib\python3.9\concurrent
#       C:\testme\msys64\mingw64\lib\python3.9\ctypes
#       C:\testme\msys64\mingw64\lib\python3.9\distutils
#       C:\testme\msys64\mingw64\lib\python3.9\email
#       C:\testme\msys64\mingw64\lib\python3.9\encodings
#       C:\testme\msys64\mingw64\lib\python3.9\ensurepip
#       C:\testme\msys64\mingw64\lib\python3.9\html
#       C:\testme\msys64\mingw64\lib\python3.9\http
#       C:\testme\msys64\mingw64\lib\python3.9\importlib
#       C:\testme\msys64\mingw64\lib\python3.9\json
#       C:\testme\msys64\mingw64\lib\python3.9\lib2to3
#       C:\testme\msys64\mingw64\lib\python3.9\lib-dynload
#       C:\testme\msys64\mingw64\lib\python3.9\logging
#       C:\testme\msys64\mingw64\lib\python3.9\msilib
#       C:\testme\msys64\mingw64\lib\python3.9\multiprocessing
#       C:\testme\msys64\mingw64\lib\python3.9\site-packages
#       C:\testme\msys64\mingw64\lib\python3.9\sqlite3
#       C:\testme\msys64\mingw64\lib\python3.9\urllib
#       C:\testme\msys64\mingw64\lib\python3.9\xml
#       C:\testme\msys64\mingw64\lib\python3.9\xmlrpc
#       C:\testme\msys64\mingw64\lib\python3.9\*.py
#       C:\testme\msys64\mingw64\lib\thread2.8.4
#       C:\testme\msys64\mingw64\lib\sqlite3.36.0
#       C:\testme\msys64\mingw64\lib\terminfo
#       C:\testme\msys64\mingw64\lib\thread2.8.4
#       C:\testme\msys64\mingw64\lib\tk8.6
#       C:\testme\msys64\mingw64\share\gettext*
#       C:\testme\msys64\mingw64\share\gir-1.0
#       C:\testme\msys64\mingw64\share\glib-2.0
#       C:\testme\msys64\mingw64\share\gtk-3.0
#       C:\testme\msys64\mingw64\share\icons
#       C:\testme\msys64\mingw64\share\locale\en*
#       C:\testme\msys64\mingw64\share\locale\locale.alias
#       C:\testme\msys64\mingw64\share\sqlite
#       C:\testme\msys64\mingw64\share\terminfo
#       C:\testme\msys64\mingw64\share\themes
#       C:\testme\msys64\mingw64\share\thumbnailers
#       C:\testme\msys64\mingw64\share\xml
#       C:\testme\msys64\mingw64\ssl
#       C:\testme\msys64\tmp
#       C:\testme\msys64\ucrt64
#       C:\testme\msys64\usr\bin\core_perl
#       C:\testme\msys64\usr\bin\site_perl
#       C:\testme\msys64\usr\bin\vendor_perl
#       C:\testme\msys64\usr\bin\AtomicParsley
#       C:\testme\msys64\usr\bin\bash
#       C:\testme\msys64\usr\bin\chmod
#       C:\testme\msys64\usr\bin\cut
#       C:\testme\msys64\usr\bin\cygpath
#       C:\testme\msys64\usr\bin\cygwin-console-helper
#       C:\testme\msys64\usr\bin\dir
#       C:\testme\msys64\usr\bin\env
#       C:\testme\msys64\usr\bin\find
#       C:\testme\msys64\usr\bin\findfs
#       C:\testme\msys64\usr\bin\getent
#       C:\testme\msys64\usr\bin\gettext*
#       C:\testme\msys64\usr\bin\gio-querymodules
#       C:\testme\msys64\usr\bin\glib-compile-schemas
#       C:\testme\msys64\usr\bin\gobject-query
#       C:\testme\msys64\usr\bin\gpg*
#       C:\testme\msys64\usr\bin\grep
#       C:\testme\msys64\usr\bin\hostid
#       C:\testme\msys64\usr\bin\hostname
#       C:\testme\msys64\usr\bin\iconv
#       C:\testme\msys64\usr\bin\id
#       C:\testme\msys64\usr\bin\ln
#       C:\testme\msys64\usr\bin\locale
#       C:\testme\msys64\usr\bin\ls
#       C:\testme\msys64\usr\bin\mintty
#       C:\testme\msys64\usr\bin\mkdir
#       C:\testme\msys64\usr\bin\msys-2.0.dll
#       C:\testme\msys64\usr\bin\msys-argp-0.dll
#       C:\testme\msys64\usr\bin\msys-assuan-0.dll
#       C:\testme\msys64\usr\bin\msys-atomic-1.dll
#       C:\testme\msys64\usr\bin\msys-bz2-1.dll
#       C:\testme\msys64\usr\bin\msys-gcc_s-1.dll
#       C:\testme\msys64\usr\bin\msys-gcrypt-20.dll
#       C:\testme\msys64\usr\bin\msys-gio-2.0-0.dll
#       C:\testme\msys64\usr\bin\msys-glib-2.0-0.dll
#       C:\testme\msys64\usr\bin\msys-gobject-2.0-0.dll
#       C:\testme\msys64\usr\bin\msys-gpg-error-0.dll
#       C:\testme\msys64\usr\bin\msys-gpgme-11.dll
#       C:\testme\msys64\usr\bin\msys-gpgmepp-6.dll
#       C:\testme\msys64\usr\bin\msys-gthread-2.0-0.dll
#       C:\testme\msys64\usr\bin\msys-iconv-2.dll
#       C:\testme\msys64\usr\bin\msys-intl-8.dll
#       C:\testme\msys64\usr\bin\msys-ncurses++w6.dll
#       C:\testme\msys64\usr\bin\msys-ncursesw6.dll
#       C:\testme\msys64\usr\bin\msys-pcre-1.dll
#       C:\testme\msys64\usr\bin\msys-pcre2-8-0.dll
#       C:\testme\msys64\usr\bin\msys-readline8.dll
#       C:\testme\msys64\usr\bin\msys-sqlite3-0.dll
#       C:\testme\msys64\usr\bin\msys-stdc++06.dll
#       C:\testme\msys64\usr\bin\msys-z.dll
#       C:\testme\msys64\usr\bin\mv
#       C:\testme\msys64\usr\bin\pac*
#       C:\testme\msys64\usr\bin\rm
#       C:\testme\msys64\usr\bin\rmdir
#       C:\testme\msys64\usr\bin\sed
#       C:\testme\msys64\usr\bin\test
#       C:\testme\msys64\usr\bin\tzset
#       C:\testme\msys64\usr\bin\uname
#       C:\testme\msys64\usr\bin\vercmp
#       C:\testme\msys64\usr\bin\which
#       C:\testme\msys64\usr\bin\xml*
#       C:\testme\msys64\usr\lib\gettext
#       C:\testme\msys64\usr\lib\gio
#       C:\testme\msys64\usr\lib\openssl
#       C:\testme\msys64\usr\lib\python3.9
#       C:\testme\msys64\usr\lib\terminfo
#       C:\testme\msys64\usr\lib\thread2.8.5
#       C:\testme\msys64\usr\share\cygwin
#       C:\testme\msys64\usr\share\glib-2.0
#       C:\testme\msys64\usr\share\mintty
#       C:\testme\msys64\usr\share\Msys
#       C:\testme\msys64\usr\share\pacman
#       C:\testme\msys64\usr\share\terminfo
#       C:\testme\msys64\usr\ssl
#       C:\testme\msys64\var\lib\pacman
#
#   - The following optional dependencies are required for fetching livestreams.
#       If you decide to install them (it's recommended that you do), run the
#       mingw64 terminal again, if it's not still open
#
#       C:\testme\msys64\mingw64.exe
#
#   - In the terminal window, type
#
#       pip3 install wheel
#       pip3 install feedparser
#       pip3 install playsound
#
#   - In the terminal window, you could add the following optional package:
#
#       pacman -S mingw-w64-x86_64-aria2
#
#   - AtomicParsley, if you want it, can be copied to this location:
#
#       C:\testme\msys64\usr\bin
#
#   - Now download the Tartube source code from
#
#       https://sourceforge.net/projects/tartube/
#
#   - Extract it, and copy the whole 'tartube' folder to
#
#       C:\testme\msys64\home\YOURNAME
#
#   - Note that YOURNAME should be substituted for your actual Windows
#       username. For example, the copied folder might be
#
#       C:\testme\msys64\home\alice\tartube
#
#   - Next, copy all of the files in
#       C:\testme\msys64\home\YOURNAME\tartube\nsis to C:\testme
#
#   - Create the installer by compiling the NSIS script,
#       C:\testme\tartube_install_64bit.nsi (the quickest way to do this is
#       by right-clicking the file and selecting 'Compile NSIS script file')
#
#   - When NSIS is finished, the installer appears in C:\testme

# Header files
# -------------------------------

    !include "MUI2.nsh"
    !include "Sections.nsh"

# General
# -------------------------------

    ;Name and file
    Name "Tartube"
    OutFile "install-tartube-2.5.113-64bit.exe"

    ;Default installation folder
    InstallDir "$LOCALAPPDATA\Tartube"

    ;Get installation folder from registry if available
    InstallDirRegKey HKCU "Software\Tartube" ""

    ;Request application privileges for Windows Vista
    RequestExecutionLevel user

    ; Extra stuff here
    BrandingText " "

# Variables
# -------------------------------

###   Var StartMenuFolder

# Interface settings
# -------------------------------

    !define MUI_ABORTWARNING
    !define MUI_ICON "tartube_icon.ico"
    !define MUI_UNICON "tartube_icon.ico"
    !define MUI_HEADERIMAGE
    !define MUI_HEADERIMAGE_BITMAP "tartube_header.bmp"
    !define MUI_HEADERIMAGE_UNBITMAP "tartube_header.bmp"
    !define MUI_WELCOMEFINISHPAGE_BITMAP "tartube_wizard.bmp"

# Pages
# -------------------------------

    !insertmacro MUI_PAGE_WELCOME

    !insertmacro MUI_PAGE_LICENSE "license.txt"

    !insertmacro MUI_PAGE_DIRECTORY

    !define MUI_STARTMENUPAGE_REGISTRY_ROOT "SHCTX"
    !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Tartube"
    !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Startmenu"
    !define MUI_STARTMENUPAGE_DEFAULTFOLDER "Tartube"

    !insertmacro MUI_PAGE_INSTFILES

    !define MUI_FINISHPAGE_RUN "$INSTDIR\msys64\home\user\tartube\tartube_64bit.bat"
    !define MUI_FINISHPAGE_RUN_TEXT "Run Tartube"
    !define MUI_FINISHPAGE_RUN_NOTCHECKED
    !define MUI_FINISHPAGE_LINK "Visit the Tartube website for the latest news \
        and support"
    !define MUI_FINISHPAGE_LINK_LOCATION "http://tartube.sourceforge.io/"
    !insertmacro MUI_PAGE_FINISH

    !insertmacro MUI_UNPAGE_CONFIRM
    !insertmacro MUI_UNPAGE_INSTFILES

# Languages
# -------------------------------

    !insertmacro MUI_LANGUAGE "English"

# Installer sections
# -------------------------------

Section "Tartube" SecClient

    SectionIn RO
    SetOutPath "$INSTDIR"

    File "tartube_icon.ico"
    File /r msys64

    SetOutPath "$INSTDIR\msys64\home\user\tartube"

    # Start Menu
    CreateDirectory "$SMPROGRAMS\Tartube"
    CreateShortCut "$SMPROGRAMS\Tartube\Tartube.lnk" \
        "$INSTDIR\msys64\home\user\tartube\tartube_64bit.bat" \
        "" "$INSTDIR\tartube_icon.ico" "" SW_SHOWMINIMIZED
    CreateShortCut "$SMPROGRAMS\Tartube\Uninstall Tartube.lnk" \
        "$INSTDIR\Uninstall.exe" \
        "" "$INSTDIR\tartube_icon.ico"

    # Desktop icon
    CreateShortcut "$DESKTOP\Tartube.lnk" \
        "$INSTDIR\msys64\home\user\tartube\tartube_64bit.bat" \
        "" "$INSTDIR\tartube_icon.ico" "" SW_SHOWMINIMIZED

    # Store installation folder
    # Commented out from v1.5.0; these instructions don't work, and probably
    #   aren't necessary anyway
#    WriteRegStr HKLM \
#        "Software\Microsoft\Windows\CurrentVersion\Uninstall\Tartube" \
#        "DisplayName" "Tartube"
#    WriteRegStr HKLM \
#        "Software\Microsoft\Windows\CurrentVersion\Uninstall\Tartube" \
#        "UninstallString" "$\"$INSTDIR\Uninstall.exe$\""
#    WriteRegStr HKLM \
#        "Software\Microsoft\Windows\CurrentVersion\Uninstall\Tartube" \
#        "Publisher" "A S Lewis"
#    WriteRegStr HKLM \
#        "Software\Microsoft\Windows\CurrentVersion\Uninstall\Tartube" \
#        "DisplayVersion" "2.5.113"

    # Create uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

# Uninstaller sections
# -------------------------------

Section "Uninstall"

    Delete "$SMPROGRAMS\Tartube\Tartube.lnk"
    Delete "$SMPROGRAMS\Tartube\Uninstall Tartube.lnk"
    Delete "$SMPROGRAMS\Tartube\Gtk graphics test.lnk"
    RMDir /r "$SMPROGRAMS\Tartube"
    Delete "$DESKTOP\Tartube.lnk"

    RMDir /r "$INSTDIR"
    Delete "$INSTDIR\Uninstall.exe"

    DeleteRegKey HKLM \
        "Software\Microsoft\Windows\CurrentVersion\Uninstall\Tartube"

SectionEnd
