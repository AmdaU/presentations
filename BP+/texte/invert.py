from PIL import Image, ImageOps, ImageChops

def invert_brightness(image_path, output_path):
    # Open the image file
    img = Image.open(image_path).convert('RGBA')
    # Separate the image into RGB and alpha channels
    rgb_img, alpha = img.split()[0:3], img.split()[3]
    rgb_img = Image.merge('RGB', rgb_img)
    # Convert the RGB image to grayscale
    grayscale = rgb_img.convert('L')
    # Invert the grayscale image
    inverted_grayscale = ImageOps.invert(grayscale)
    # Convert the inverted grayscale image back to RGB
    inverted_grayscale = inverted_grayscale.convert('RGB')
    # Apply the inverted grayscale image as a luminance map
    result = ImageChops.lighter(rgb_img, inverted_grayscale)
    # Merge the result with the alpha channel
    result = Image.merge('RGBA', result.split()[0:3] + (alpha,))
    # Save the result
    result.save(output_path)
# Use the function
invert_brightness('output.png', 'inverted.png')
