#!/bin/python3
#Source: https://github.com/JongWasTaken/wl-random-wallpaper
#Original Author: JongWasTaken
#Modified by: NextProgram

# SETTINGS
TIME = 300 # seconds
FANCY = True # causes applications to lag on my machine
WALLPAPER_DIRECTORY = "~/Pictures/wallpapers/"

# CODE
import os
import random
import subprocess
import threading

def command(cmd):
    return os.popen(cmd).read().strip()

# This is a workaround related to swww-daemon crashing randomly since 0.7.x
command("rm -rf  ~/.cache/swww/")

if command("pidof swww-daemon") == "":
    command("swww init")

command("killall swaybg")

wallpaperDir = os.path.expanduser(WALLPAPER_DIRECTORY)
wallpaperMemory = []

def set_interval(func, sec):
    def func_wrapper():
        set_interval(func, sec)
        func()
    t = threading.Timer(sec, func_wrapper)
    t.start()
    return t


def random_screen_pos():
    """ return random.choice([
    "top-left",
    "top-right",
    "bottom-left",
    "bottom-right",
    "center",
    "top",
    "bottom",
    "left",
    "right"
    ]) """
    return f"{round(random.random(), 2)},{round(random.random(), 2)}"
    

def set_wallpaper():
    if os.path.exists(os.path.expanduser("~/.disable-random-wallpaper")):
        print("~/.disable-random-wallpaper found: script disabled!")
        return

    global wallpaperDir
    global wallpaperMemory
    global FANCY

    print("changing wallpaper...")
    print("memory size: " + str(len(wallpaperMemory)))
    print("memory content: ")
    for string in wallpaperMemory:
        print(" - " + string)

    wallpapers = os.listdir(wallpaperDir)

    if len(wallpaperMemory) != 0:
        for entry in wallpaperMemory:
            try:
                wallpapers.remove(entry)
            except:
                # We need something here because python
                print("Could not find current wallpaper in wallpaper folder!")

    if wallpapers:
        wp = wallpapers.pop(random.randint(0, len(wallpapers)-1))
        if FANCY:
            command(f"swww img {wallpaperDir}/{wp} --transition-type grow --transition-duration=5 --transition-fps=60 --transition-pos {random_screen_pos()}")
        else:
            command("swww img -t none " + wallpaperDir + "/" + wp) # --transition-type simple --transition-step 30 
        wallpaperMemory = [wp]
    else:
        print("No wallpapers found in the directory.")

    return

set_wallpaper()
set_interval(set_wallpaper, TIME)
