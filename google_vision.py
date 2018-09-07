import io
import sys

from google.cloud import vision

class ocr_google:

    def text_from_image(self, filename):

        reload(sys)
        sys.setdefaultencoding('utf8')
        client = vision.ImageAnnotatorClient()

        with io.open(filename, 'rb') as image_file:
            content = image_file.read()

        image = vision.types.Image(content=content)

        response = client.text_detection(image=image)
        texts = response.text_annotations
        result = ""

        for text in texts:
            result += text.description

        return  result