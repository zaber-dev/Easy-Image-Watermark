from PIL import Image
import sys
import os

def add_watermark(input_image_path, watermark_path, output_folder):
    try:
        # Open the main image
        image = Image.open(input_image_path).convert("RGBA")
        watermark = Image.open(watermark_path).convert("RGBA")

        # Resize watermark dynamically (10% of image width)
        img_width, img_height = image.size
        wm_width, wm_height = watermark.size
        scale_factor = img_width / wm_width * 0.10
        new_wm_size = (int(wm_width * scale_factor), int(wm_height * scale_factor))
        watermark = watermark.resize(new_wm_size, Image.LANCZOS)

        # Position watermark at bottom-right with margin
        wm_x = img_width - new_wm_size[0] - 20
        wm_y = img_height - new_wm_size[1] - 20

        # Apply watermark
        transparent = Image.new("RGBA", image.size, (0, 0, 0, 0))
        transparent.paste(image, (0, 0))
        transparent.paste(watermark, (wm_x, wm_y), watermark)
        final_image = transparent.convert("RGB")

        # Save output image
        os.makedirs(output_folder, exist_ok=True)
        output_path = os.path.join(output_folder, os.path.basename(input_image_path))

        # Save in correct format
        ext = input_image_path.split('.')[-1].lower()
        if ext in ["jpg", "jpeg"]:
            final_image.save(output_path, "JPEG", quality=95)
        elif ext == "png":
            final_image.save(output_path, "PNG")
        elif ext == "bmp":
            final_image.save(output_path, "BMP")
        elif ext == "gif":
            final_image.save(output_path, "GIF")
        elif ext == "webp":
            final_image.save(output_path, "WEBP")
        elif ext == "tiff":
            final_image.save(output_path, "TIFF")
        else:
            final_image.save(output_path, "PNG")  # Default to PNG if unknown format

        print(f"✔ Watermarked: {output_path}")

    except Exception as e:
        print(f"❌ Error processing {input_image_path}: {e}", file=sys.stderr)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python add_image.py <image_path> <watermark_path> <output_folder>")
        sys.exit(1)

    add_watermark(sys.argv[1], sys.argv[2], sys.argv[3])
