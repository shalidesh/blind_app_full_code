from colormath.color_objects import sRGBColor, LCHabColor
from colormath.color_conversions import convert_color

from webcolors import rgb_to_name, CSS3_HEX_TO_NAMES
from scipy.spatial import KDTree
import numpy as np

# Define the input color as an sRGBColor object
input_color = sRGBColor(0.5, 0.2, 0.8)

# Convert the input color to the LCHab color space
input_color_lch = convert_color(input_color, LCHabColor)

# Calculate the triadic colors by rotating the hue by 120 and 240 degrees
triadic_color1_lch = LCHabColor(
    input_color_lch.lch_l,
    input_color_lch.lch_c,
    (input_color_lch.lch_h + 120) % 360
)
triadic_color2_lch = LCHabColor(
    input_color_lch.lch_l,
    input_color_lch.lch_c,
    (input_color_lch.lch_h + 240) % 360
)

# Convert the triadic colors back to the sRGB color space
triadic_color1 = convert_color(triadic_color1_lch, sRGBColor)
triadic_color2 = convert_color(triadic_color2_lch, sRGBColor)

# Print the RGB values of the triadic colors
print(triadic_color1.get_value_tuple())
print(triadic_color2.get_value_tuple())


def get_color_name(srgb):
    # Convert sRGB values from 0-1 range to 0-255 range
    rgb = tuple(np.array(srgb) * 255)
    # Create a KDTree for the CSS3 colors
    css3_colors = np.array([tuple(int(color[i:i+2], 16) for i in (1, 3, 5)) for color in CSS3_HEX_TO_NAMES])
    css3_kdtree = KDTree(css3_colors)
    # Find the closest CSS3 color to the input color
    dist, index = css3_kdtree.query(rgb)
    # Check if the index is a valid key for the CSS3_HEX_TO_NAMES dictionary
    if index in CSS3_HEX_TO_NAMES:
        color_hex = CSS3_HEX_TO_NAMES[index]
        # Get the name of the closest color
        color_name = rgb_to_name(color_hex, spec='css3')
        return color_name
    else:
        return "Unknown Color"


print(get_color_name(triadic_color1.get_value_tuple()))
print(get_color_name(triadic_color2.get_value_tuple()))


# Color theory is a field of study that explores how colors can be combined in a visually pleasing way. It provides a set of principles and guidelines for creating harmonious color schemes, based on the relationships between colors on the color wheel.

# A color scheme is a selection of colors that are used together in a design or composition. Color schemes can be created using various methods, such as choosing complementary, analogous, triadic, or tetradic colors.

# For example, a complementary color scheme is created by choosing two colors that are opposite each other on the color wheel. An analogous color scheme is created by choosing three colors that are next to each other on the color wheel. A triadic color scheme is created by choosing three colors that are evenly spaced around the color wheel.

# By using color theory to generate a color scheme, you can ensure that the colors you choose will work well together and create a harmonious and visually pleasing result.





# from colorthief import ColorThief
# import matplotlib.pyplot as plt

# color_thief = ColorThief('IMG_20230715_234900.jpg')
# # get the dominant color
# dominant_color = color_thief.get_color(quality=1)
# # build a color palette
# palette = color_thief.get_palette(color_count=3)

# print(palette)


# import webcolors
# import numpy as np

# def closest_color(requested_color):
#     min_colors = {}
#     for key, name in webcolors.CSS3_HEX_TO_NAMES.items():
#         r_c, g_c, b_c = webcolors.hex_to_rgb(key)
#         rd = (r_c - requested_color[0]) ** 2
#         gd = (g_c - requested_color[1]) ** 2
#         bd = (b_c - requested_color[2]) ** 2
#         min_colors[(rd + gd + bd)] = name
#     return min_colors[min(min_colors.keys())]

# def get_color_name(requested_color):
#     try:
#         closest_name = actual_name = webcolors.rgb_to_name(requested_color)
#     except ValueError:
#         closest_name = closest_color(requested_color)
#         actual_name = None
#     return actual_name, closest_name

# requested_color = (63, 79, 175)
# actual_name, closest_name = get_color_name(requested_color)

# print("Actual color name:", actual_name, ", Closest color name:", closest_name)



