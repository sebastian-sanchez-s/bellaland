from PIL import Image
import sys

def make_sprite():
    if len(sys.argv[1:]) < 4:
        print("Usage: python maker.py [filename_pattern] [filename_type] [start_index] [finish_index]")
        sys.exit(0)

    name, end, istart, ifinish = sys.argv[1:]


    size = input("Size [width height]: ")

    if size != "":
        size = list(map(int,size.split()))
    
    filenames = []
    istart = int(istart)
    ifinish = int(ifinish)
    for index in range(istart, ifinish+1):
        filenames.append(f"{name}{index}{end}")

    images = []
    print("Loading images")
    for filename in filenames:

        img = Image.open(filename, "r")
        
        # resize image
        if len(size) == 2:
            img = img.resize(tuple(size))

        images.append(img)

    print("Building sprite")
    # asumming all are the same size
    width, height = images[0].size

    master_image = Image.new('RGBA', (width*len(filenames), height), (0,0,0,0))
    
    offset = 0
    for img in images:
        master_image.paste(img, (offset, 0))
        offset += width

        img.close()

    name = input("Output filename: ")
    master_image.save(name+".png")
    
    

if __name__ == "__main__":
    make_sprite()
