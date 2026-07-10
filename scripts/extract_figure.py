import sys

import pdfplumber


def extract_figure(pdf_path, page_num, out_path, resolution=200, pad=15):
    with pdfplumber.open(pdf_path) as pdf:
        page = pdf.pages[page_num - 1]
        area_threshold = 0.05 * page.width * page.height
        images = [
            im for im in page.images
            if (im["x1"] - im["x0"]) * (im["bottom"] - im["top"]) > area_threshold
        ]
        if images:
            # full page width so wrap-around captions don't get clipped;
            # crop tightly only in the vertical direction
            top = max(0, min(im["top"] for im in images) - pad)
            bottom = min(page.height, max(im["bottom"] for im in images) + pad * 2)
            target = page.crop((0, top, page.width, bottom))
        else:
            target = page
        target.to_image(resolution=resolution).save(out_path, format="PNG")


if __name__ == "__main__":
    extract_figure(sys.argv[1], int(sys.argv[2]), sys.argv[3])
