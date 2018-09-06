import os.path

from robot.libraries.BuiltIn import BuiltIn

class Capture:

    def crop_only_photo(self, output_dir, filename, left, top, width, height):
        """Crop the saved image with given filename for the given dimensions.
        """
        from PIL import Image
        from PIL import ImageFilter

        img = Image.open(os.path.join(output_dir, filename))
        box = (int(left), int(top), int(width), int(height))

        area = img.crop(box)
        area2 = area.filter(ImageFilter.SHARPEN)

        with open(os.path.join(output_dir, filename), 'wb') as output:
            area2.save(output, 'png')