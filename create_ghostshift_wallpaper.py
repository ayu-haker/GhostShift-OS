#!/usr/bin/env python3
"""
Generate GhostShift OS wallpaper
Creates a PNG image with the GhostShift logo on a dark background
"""

from PIL import Image, ImageDraw, ImageFont
import math

# Image dimensions (common desktop resolution)
WIDTH = 1920
HEIGHT = 1080

# Colors matching your logo
BG_COLOR = (0, 10, 5)  # Very dark green/black
GHOST_GREEN = (0, 255, 100)  # Bright neon green
GLOW_GREEN = (0, 180, 60)  # Medium green for glow

def create_ghostshift_wallpaper():
    # Create image with dark background
    img = Image.new('RGB', (WIDTH, HEIGHT), BG_COLOR)
    draw = ImageDraw.Draw(img)
    
    # Center position for logo
    center_x = WIDTH // 2
    center_y = HEIGHT // 2 - 100
    
    # Draw ghost hood (simplified circle/oval)
    hood_radius = 150
    
    # Draw glow effect (multiple circles with decreasing opacity)
    for i in range(10, 0, -1):
        alpha_val = int(255 * (i / 10) * 0.3)
        glow_radius = hood_radius + (i * 10)
        glow_color = (0, int(255 * (i / 10) * 0.7), int(100 * (i / 10) * 0.7))
        draw.ellipse(
            [center_x - glow_radius, center_y - glow_radius,
             center_x + glow_radius, center_y + glow_radius],
            fill=None,
            outline=glow_color,
            width=3
        )
    
    # Draw main hood outline
    draw.ellipse(
        [center_x - hood_radius, center_y - hood_radius,
         center_x + hood_radius, center_y + hood_radius],
        outline=GHOST_GREEN,
        width=8
    )
    
    # Draw face circle
    face_radius = 100
    draw.ellipse(
        [center_x - face_radius, center_y - face_radius + 20,
         center_x + face_radius, center_y + face_radius + 20],
        outline=GHOST_GREEN,
        width=6
    )
    
    # Draw eyes (glowing)
    eye_y = center_y
    eye_radius = 15
    # Left eye
    draw.ellipse(
        [center_x - 40 - eye_radius, eye_y - eye_radius,
         center_x - 40 + eye_radius, eye_y + eye_radius],
        fill=GHOST_GREEN
    )
    # Right eye
    draw.ellipse(
        [center_x + 40 - eye_radius, eye_y - eye_radius,
         center_x + 40 + eye_radius, eye_y + eye_radius],
        fill=GHOST_GREEN
    )
    
    # Draw smile (curved line)
    smile_points = []
    for x in range(-50, 51, 5):
        y = int((x * x) / 100) + 40
        smile_points.append((center_x + x, center_y + y))
    draw.line(smile_points, fill=GHOST_GREEN, width=6)
    
    # Draw "GhostShift OS" text
    try:
        # Try to use a nice font
        font_large = ImageFont.truetype("arial.ttf", 120)
        font_small = ImageFont.truetype("arial.ttf", 40)
    except:
        # Fallback to default font
        font_large = ImageFont.load_default()
        font_small = ImageFont.load_default()
    
    # Main title
    text = "GhostShift OS"
    text_bbox = draw.textbbox((0, 0), text, font=font_large)
    text_width = text_bbox[2] - text_bbox[0]
    text_x = center_x - text_width // 2
    text_y = center_y + 200
    
    # Draw text with glow effect
    for offset in range(5, 0, -1):
        glow_alpha = int(255 * (offset / 5) * 0.5)
        glow_col = (0, int(180 * (offset / 5)), int(60 * (offset / 5)))
        draw.text((text_x + offset, text_y + offset), text, font=font_large, fill=glow_col)
        draw.text((text_x - offset, text_y - offset), text, font=font_large, fill=glow_col)
    
    draw.text((text_x, text_y), text, font=font_large, fill=GHOST_GREEN)
    
    # Subtitle
    subtitle = "Secure • Anonymous • Fast"
    sub_bbox = draw.textbbox((0, 0), subtitle, font=font_small)
    sub_width = sub_bbox[2] - sub_bbox[0]
    sub_x = center_x - sub_width // 2
    sub_y = text_y + 140
    draw.text((sub_x, sub_y), subtitle, font=font_small, fill=GLOW_GREEN)
    
    # Save the image
    img.save('Base/res/wallpapers/ghostshift.png')
    print("✓ GhostShift wallpaper created: Base/res/wallpapers/ghostshift.png")
    
    # Also create a smaller version for boot splash
    small_img = img.resize((800, 600), Image.Resampling.LANCZOS)
    small_img.save('Base/res/graphics/ghostshift-boot.png')
    print("✓ Boot splash created: Base/res/graphics/ghostshift-boot.png")

if __name__ == "__main__":
    create_ghostshift_wallpaper()
