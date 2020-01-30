# It was necessary to modify the rdp database otherwise the rdp classifier did not work
try:
    with open("edt_trainset16_022016.rdp.tax","w") as newFile:
        with open("/PATH/TO/trainset16_022016.rdp.tax","r") as myFile:
            for line in myFile:
                auxStr = line

                while(auxStr.count(';') < 6):
                    if auxStr.endswith('\n'):
                        auxStr = auxStr.replace('\n',';\n')
                    else:
                        auxStr = auxStr + ";"
                newFile.write(auxStr)
    newFile.close()
except:
    print("Not possible to edit file")