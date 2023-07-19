
import datetime

def parseddmmyy(inp):
    return datetime.datetime.strptime(inp, "%d-%m-%Y").date()

def printNewL():
    for i in range(2):
        print()

def printNewLines():
   print("\033c")