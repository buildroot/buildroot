import fitz_old as fitz

# Write a test PDF file
outfile = "python-pymupdf.pdf"
sample_text = "This is a test page for python-pymupdf."
doc = fitz.open()
page = doc.new_page()
p = fitz.Point(50, 72)
page.insert_text(p, sample_text)
doc.save(outfile)

# Read back the file
with fitz.open(outfile) as d:  # open document
    read_text = chr(12).join([page.get_text() for page in d])

print(read_text)
assert(read_text == sample_text + "\n")
