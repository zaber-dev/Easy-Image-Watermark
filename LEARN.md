# Learning Resources for Image Processing Tool

## Overview

This project demonstrates how to automate image processing tasks using a combination of a batch script and a Python script. The batch script handles the environment setup and user interaction, while the Python script performs the actual image processing.

## Key Concepts

### Batch Scripting

- **Environment Setup**: The batch script checks for the presence of Python and installs it if necessary. It also ensures that the required Python package (Pillow) is installed.
- **User Interaction**: The script provides a simple menu for the user to interact with, allowing them to choose between processing images, viewing information about the tool, or exiting the program.

### Python Scripting

- **Image Processing**: The Python script uses the Pillow library to open images, apply a watermark, and save the processed images in the appropriate format.
- **Error Handling**: The script includes error handling to manage issues such as missing files or unsupported image formats.

## Further Reading

- [Batch Script Basics](https://www.tutorialspoint.com/batch_script/index.htm)
- [Python Programming](https://docs.python.org/3/tutorial/)
- [Pillow Documentation](https://pillow.readthedocs.io/en/stable/)

## Advanced Topics

- **Dynamic Watermark Resizing**: The script dynamically resizes the watermark to 10% of the image width, ensuring that the watermark is appropriately scaled for images of different sizes.
- **Image Format Handling**: The script supports multiple image formats and saves the processed images in the correct format based on the input image.

## Conclusion

This project provides a practical example of how to combine batch scripting and Python scripting to automate a common task. By studying the provided scripts and resources, you can learn how to create similar automation tools for other tasks.

## Contact

For any questions or further information, please visit [www.zealtyro.com](http://www.zealtyro.com).