import os
if __name__ == '__main__':
    filepath = "assets/images/"
    names=sorted(os.listdir(filepath))
    # names = file_name(filepath)

    for name in names:

        print("- "+filepath+name)