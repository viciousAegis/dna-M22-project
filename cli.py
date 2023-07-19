from inspect import getmembers, isfunction
import pymysql
import pymysql.cursors

import queries
import utils

quer = []
for name, val in getmembers(queries):
    if isfunction(val):
        quer.append(val)

GREETINGS = """
  ___            ___  
 (o o)          (o o) 
(  V  ) CUMBUM (  V  )
--m-m------------m-m--
!! WELCOME TO CUMBUM !!
"""

def main():
    connection = pymysql.connect(
        host="localhost",
        user="cumbum",
        password="cumbum",
        database="cumbum",
        cursorclass=pymysql.cursors.DictCursor,
    )

    with connection:
        while True:
            utils.printNewLines()
            try:
                print(GREETINGS)
                utils.printNewL()
                print("Choose an option: ")
                for idx, query in enumerate(quer):
                    print(f"{idx + 1}: {query.__doc__}")
                try:
                    choice = int(input("Option: ")) - 1
                except:
                    break
                with connection.cursor() as cursor:
                    quer[choice](cursor)
                connection.commit()
            except Exception as e:
                print(e)
            finally:
                print()
                input("Press enter to continue...")

if __name__ == '__main__':
    main()