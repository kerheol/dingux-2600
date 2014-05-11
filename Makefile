#
# Atari 2600 / Stella port on PSP
#
# Copyright (C) 2009 Ludovic Jacomme (ludovic.jacomme@gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
ATARI_VERSION=1.1.0

TARGET = dingux-2600
SDL_CONFIG = /opt/gcw0-toolchain/usr/mipsel-gcw0-linux-uclibc/sysroot/usr/bin/sdl-config
OBJS = gp2x_psp.o \
Atari.o  \
psp_main.o \
psp_sdl.o \
psp_kbd.o \
psp_font.o \
psp_menu.o \
psp_joy.o \
psp_danzeff.o \
psp_menu_set.o \
psp_menu_help.o \
psp_menu_joy.o \
psp_menu_kbd.o \
psp_menu_cheat.o \
psp_menu_list.o \
psp_editor.o \
psp_fmgr.o \
\
emucore/Joystick.o \
emucore/TIA.o \
emucore/Settings.o \
emucore/CartE0.o \
emucore/Paddles.o \
emucore/CartF8.o \
emucore/Props.o \
emucore/Switches.o \
emucore/Event.o \
emucore/Random.o \
emucore/Device.o \
emucore/Driving.o \
emucore/Cart2K.o \
emucore/Keyboard.o \
emucore/Console.o \
emucore/CartF6.o \
emucore/M6532.o \
emucore/PropsSet.o \
emucore/CartUA.o \
emucore/CartMC.o \
emucore/CartFE.o \
emucore/CartMB.o \
emucore/CartF8SC.o \
emucore/CartF6SC.o \
emucore/Cart.o \
emucore/CartF4SC.o \
emucore/CartF4.o \
emucore/CartE7.o \
emucore/CartCV.o \
emucore/FSNode.o \
emucore/FrameBuffer.o \
emucore/MD5.o \
emucore/MediaSrc.o \
emucore/MediaFactory.o \
emucore/CartAR.o \
emucore/CartFASC.o \
emucore/Cart4K.o \
emucore/Control.o \
emucore/Cart3F.o \
emucore/Cart3E.o \
emucore/Booster.o \
emucore/CartDPC.o \
emucore/Deserializer.o \
emucore/EventHandler.o \
emucore/EventStreamer.o \
emucore/Serializer.o \
emucore/M6502.o \
emucore/M6502Hi.o \
emucore/M6502Low.o \
emucore/NullDev.o \
emucore/System.o \
emucore/OSystem.o \
\
emucore/unzip.o \
emucore/TIASnd.o \
\
common/FrameBufferSoft.o \
common/mainSDL.o \
common/SoundSDL.o \
\
psp/OSystemPSP.o \
psp/SettingsPSP.o \
psp/FSNodePSP.o \


CC=/opt/gcw0-toolchain/usr/bin/mipsel-linux-gcc
CXX=/opt/gcw0-toolchain/usr/bin/mipsel-linux-g++
STRIP=/opt/gcw0-toolchain/usr/bin/mipsel-linux-strip

DEFAULT_CFLAGS = $(shell $(SDL_CONFIG) --cflags)

MORE_CFLAGS = \
-I. -I$/opt/gcw0-toolchain/usr/mipsel-gcw0-linux-uclibc/sysroot/usr/include \
 -DMPU_JZ4740 -mips32 \
 -Iemucore -Icommon -Ipsp -DPSP -DBSPF_PSP -DSOUND_SUPPORT \
 -O3 -fsigned-char -ffast-math -fomit-frame-pointer -fno-strength-reduce \
 -DNO_STDIO_REDIRECT -DGCW0_MODE \
 -DATARI_VERSION=\"$(ATARI_VERSION)\" \
 -std=c++11
 #-Wwrite-strings -fpermissive

CFLAGS = $(DEFAULT_CFLAGS) $(MORE_CFLAGS)
LDFLAGS = -s

LIBS += -L/opt/gcw0-toolchain/usr/mipsel-gcw0-linux-uclibc/sysroot/usr/lib \
-lSDL \
-lSDL_image \
-lpng -lz -lm -lpthread -lstdc++ -ldl


.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.cpp.o:
	$(CXX) $(CFLAGS) -c $< -o $@

all: $(OBJS)
	$(CC) $(LDFLAGS) $(CFLAGS) $(OBJS) $(LIBS) -o $(TARGET) && $(STRIP) $(TARGET)

install: $(TARGET)
	cp $< /media/dingux/local/emulators/dingux-2600/

clean:
	rm -f $(OBJS) $(TARGET)
	rm -f dingux-2600.dge

ctags:
	ctags *[ch] emucore/*[chp] common/*[chp]
